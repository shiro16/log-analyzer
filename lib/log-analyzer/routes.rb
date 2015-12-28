require 'action_dispatch/journey'
require 'action_dispatch'

module Log::Analyzer
  class Routes < ActionDispatch::Journey::Routes

    def initialize(routes_text)
      super()
      routes_text.scan(/(GET|POST)\s+([^\s]*)\s/) do |request_method, request_path|
        path_pattern = Log::Analyzer::Pattern.from_string(request_path)
        add_route(nil, path_pattern, {request_method: [request_method]}, {}, {})
      end
    end
  end
end
