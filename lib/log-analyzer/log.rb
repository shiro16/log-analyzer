module Log::Analyzer
  class Log
    def initialize(path)
      @file = File.open(path)
    end

    def each_line(&block)
      @file.each_line(separator) do |line|
        next unless md = line.scrub('').match(regexp)
        env = md.names.inject({'HTTP_X_REQUESTED_WITH' => 'XMLHttpRequest'}) do |hash, name|
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
      ::Log::Analyzer.config.log_separator.gsub("\\n", "\n")
    end
  end
end
