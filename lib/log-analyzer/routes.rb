require 'action_dispatch/journey'
require 'action_dispatch'

module Log::Analyzer
  class Routes < ActionDispatch::Journey::Routes
    ROUTE_REGEXP = /(GET|POST|DELETE|PATCH|PUT)\s+([^\s]*)\s/

    def initialize(routes_text)
      super()
      routes_text.scan(ROUTE_REGEXP) do |request_method, request_path|
        path_pattern = Pattern.from_string(request_method, request_path)
        add_route(nil, path_pattern, {request_method: /^#{request_method}$/}, {}, {})
      end
    end
  end
end
