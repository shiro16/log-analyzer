module Log::Analyzer::Rails
  class RoutesInspector < ::ActionDispatch::Routing::RoutesInspector
    private
    def collect_routes(routes)
      routes.collect do |route|
        ::ActionDispatch::Routing::RouteWrapper.new(route)
      end.reject do |route|
        route.internal?
      end.collect do |route|
        collect_engine_routes(route)
        constraints = collect_constraints(route)

        { name:   route.name,
          verb:   route.verb,
          path:   route.path,
          reqs:   route.reqs,
          regexp: route.json_regexp,
          constraints: constraints }
      end
    end

    def collect_constraints(route)
      return [] unless route.app.respond_to?(:constraints)

      route.app.constraints.collect do |constraint|
        case
        when constraint.respond_to?(:matches?)
          constraint.class
        when constraint.respond_to?(:call)
          constraint.source.match(/constraints: (.*)/) do |md|
            md[1]
          end
        else
          nil
        end
      end
    end
  end

  class ConsoleFormatter < ::ActionDispatch::Routing::ConsoleFormatter
    private
    def draw_section(routes)
      header_lengths = ['Prefix', 'Verb', 'URI Pattern', 'Controller#Action'].map(&:length)
      name_width, verb_width, path_width, reqs_width = widths(routes).zip(header_lengths).map(&:max)

      routes.map do |r|
        "#{r[:name].rjust(name_width)} #{r[:verb].ljust(verb_width)} #{r[:path].ljust(path_width)} #{r[:reqs].ljust(reqs_width)} #{r[:constraints]}"
      end
    end

    def draw_header(routes)
      name_width, verb_width, path_width, reqs_width = widths(routes)

      "#{"Prefix".rjust(name_width)} #{"Verb".ljust(verb_width)} #{"URI Pattern".ljust(path_width)} #{"Controller#Action".ljust(reqs_width)} Constraints"
    end

    def widths(routes)
      [routes.map { |r| r[:name].length }.max || 0,
       routes.map { |r| r[:verb].length }.max || 0,
       routes.map { |r| r[:path].length }.max || 0,
       routes.map { |r| r[:reqs].length }.max || 0]
    end
  end
end
