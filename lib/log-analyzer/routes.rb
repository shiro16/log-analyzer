require 'action_dispatch/journey'
require 'action_dispatch'

module Log::Analyzer
  class Routes < ActionDispatch::Journey::Routes
    def initialize(routes_text)
      super()
      routes_text.scan(regexp) do |request_method, request_path, requirements, constraints|
        constraints = if constraints.nil? || constraints.empty?
                        []
                      else
                        eval(constraints)
                      end.map do |constraint|
                        constraint.is_a?(String) ? eval(constraint) : constraint
                      end
        app = ActionDispatch::Routing::Mapper::Constraints.new(constraints, {}, false)

        path_pattern = Pattern.from_string(request_method, request_path, requirements)
        add_route(app, path_pattern, {request_method: /^#{request_method}$/}, {}, {})
      end
    end

    private
    def regexp
      ::Log::Analyzer.config.route_regexp
    end
  end
end
