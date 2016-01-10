module Log::Analyzer
  class Analyze
    def initialize(files, routes_text)
      @files = Dir.glob(files).select { |f| File.file?(f) }
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

          req.env.delete_if { |key, val| ["REQUEST_METHOD", "PATH_INFO"].include?(key) }
          _, _, route =  matche.first
          endpoint = Endpoint.find_by(method: route.path.request_method, uri_pattern: route.path.uri_pattern)
          endpoint.count += 1

          req.env.each do |key, val|
            endpoint[key.downcase] << val.to_i
          end
        end
      end
      Endpoint.all
    end

    def create_endpoints
      @routes.each { |route| Endpoint.create(method: route.path.request_method, uri_pattern: route.path.uri_pattern) }
    end
  end
end
