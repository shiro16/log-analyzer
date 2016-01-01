module Log::Analyzer
  class Config
    attr_accessor :log_regexp, :route_regexp

    def initialize
      @log_regexp = /Started (?<request_method>GET|POST|DELETE|PATCH|PUT) "(?<path_info>[^"]+)"/i
      @route_regexp = /(GET|POST|DELETE|PATCH|PUT)\s+([^\s]*)\s/i
    end
  end
end
