module Log::Analyzer
  class Mapper
    def initialize(routes)
      @routes = routes
    end

    def serve(req)
      @routes.send(:find_routes, req)
    end
  end
end
