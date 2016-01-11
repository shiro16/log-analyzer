module Log::Analyzer
  class Router < ActionDispatch::Journey::Router
    def serve(req)
      find_routes(req).each do |match, parameters, route|
        set_params  = req.path_parameters
        path_info   = req.path_info
        script_name = req.script_name

        unless route.path.anchored
          req.script_name = (script_name.to_s + match.to_s).chomp('/')
          req.path_info = match.post_match
          req.path_info = "/" + req.path_info unless req.path_info.start_with? "/"
        end

        req.path_parameters = set_params.merge parameters
        unless route.app.matches?(req)
          req.script_name     = script_name
          req.path_info       = path_info
          req.path_parameters = set_params
          next
        end

        return route
      end

      nil
    end
  end
end
