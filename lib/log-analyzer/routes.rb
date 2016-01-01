require 'action_dispatch/journey'
require 'action_dispatch'

module Log::Analyzer
  class Routes < ActionDispatch::Journey::Routes
    def initialize(routes_text)
      super()
      routes_text.scan(regexp) do |request_method, request_path|
        path_pattern = Pattern.from_string(request_method, request_path)
        add_route(nil, path_pattern, {request_method: /^#{request_method}$/}, {}, {})
      end
    end

    private
    def regexp
      ::Log::Analyzer.config.route_regexp
    end
  end
end
