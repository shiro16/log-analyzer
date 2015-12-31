module Log::Analyzer
  class Log
    LOG_REGEXP = /Started (?<request_method>GET|POST|DELETE|PATCH|PUT) "(?<path_info>[^"]+)"/i

    def initialize(path)
      @file = File.open(path)
    end

    def each_line(&block)
      @file.each_line do |line|
        next unless md = line.match(LOG_REGEXP)
        env = md.names.inject({}) do |hash, name|
                hash[name.upcase] = md[name]
                hash
              end
        block.call(ActionDispatch::Request.new(env))
      end
    end
  end
end
