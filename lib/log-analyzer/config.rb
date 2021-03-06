module Log::Analyzer
  class Config
    attr_accessor :log_regexp, :route_regexp, :log_separator

    def initialize
      @route_regexp = /(GET|POST|DELETE|PATCH|PUT)\s*([^\s]*)\s*[^\s]*\s*(\{.*\})?\s*(\[.*\])?/i
      @log_regexp = /Started (?<request_method>GET|POST|DELETE|PATCH|PUT) "(?<path_info>[^"]+)".*in (?<response_time>[0-9]+)ms/im
      @log_separator = "\n\n\n"
    end
  end
end
