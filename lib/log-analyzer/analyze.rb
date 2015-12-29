module Log::Analyzer
  class Analyze
    def initialize(files, routes_text)
      files = [files] unless files.is_a?(Array)
      @files = files
      @routes = Log::Analyzer::Routes.new(routes_text)
    end

    def result
      @result ||= matche
    end

    def sort
      result.sort_by{ |key, val| -val }.to_h
    end

    private
    def router
      @router ||= Log::Analyzer::Router.new(@routes)
    end

    def matche
      @files.inject(format) do |result, file|
        log = Log::Analyze::Log.new(file)
        log.each_line do |req|
          matche = router.serve(req)
          next unless matche.any?

          _, _, route =  matche.first
          result[route.path.uri_pattern] += 1
        end
        result
      end
    end

    def format
      @routes.inject(Hash.new(0)) do |hash, route|
        hash[route.path.uri_pattern] = 0
        hash
      end
    end
  end
end
