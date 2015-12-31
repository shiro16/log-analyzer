module Log::Analyzer
  class Analyze
    def initialize(files, routes_text)
      @files =files.is_a?(Array) ? files : [files]
      @routes = Routes.new(routes_text)
      create_endpoints
    end

    def result
      @result ||= matche
    end

    def sort
      result.sort{ |a, b| b.count <=> a.count }
    end

    private
    def router
      @router ||= Router.new(@routes)
    end

    def matche
      @files.each do |file|
        log = Log.new(file)
        log.each_line do |req|
          matche = router.serve(req)
          next unless matche.any?

          _, _, route =  matche.first
          endpoint = Endpoint.find_by(method: route.path.request_method, uri_pattern: route.path.uri_pattern)
          endpoint.count += 1
        end
      end
      Endpoint.all
    end

    def create_endpoints
      @routes.each { |route| Endpoint.create(method: route.path.request_method, uri_pattern: route.path.uri_pattern) }
    end
  end
end
