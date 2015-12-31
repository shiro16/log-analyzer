module Log::Analyzer
  class Log
    def initialize(path)
      @file = File.open(path)
    end

    def each_line(&block)
      @file.each_line do |line|
        next unless md = line.match(/Started (?<request_method>GET|POST|DELETE|PATCH|PUT) "(?<path_info>[^"]+)"/)
        env = md.names.inject({}) do |hash, name|
                hash[name.upcase] = md[name]
                hash
              end
        block.call(ActionDispatch::Request.new(env))
      end
    end
  end
end
