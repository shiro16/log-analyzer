module Log::Analyzer
  class Log
    def initialize(path)
      @file = File.open(path)
    end

    def each_line(&block)
      @file.each_line(separator) do |line|
        next unless md = line.match(regexp)
        env = md.names.inject({}) do |hash, name|
                hash[name.upcase] = md[name]
                hash
              end
        block.call(ActionDispatch::Request.new(env))
      end
    end

    private
    def regexp
      ::Log::Analyzer.config.log_regexp
    end

    def separator
      ::Log::Analyzer.config.log_separator
    end
  end
end
