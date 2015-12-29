module Log::Analyzer
  class Router < ActionDispatch::Journey::Router
    def serve(req)
      find_routes(req)
    end
  end
end
