require 'command_line_reporter'

module Log::Analyzer
  class CLI
    def self.run(files, options)
      routing_text = File.read(options[:r])
      analyze = Log::Analyzer::Analyze.new(files, routing_text)
      result = analyze.sort
      Report.new(result).run
    end

    class Report
      include CommandLineReporter

      def initialize(hash)
        @hash = hash
      end

      def run
        table(width: :auto, border: true) do
          row header: true, color: 'red' do
            column('endpoint')
            column('count')
          end
          @hash.each do |key, value|
            row color: 'red' do
              column(key)
              column(value)
            end
          end
        end
      end
    end
  end
end
