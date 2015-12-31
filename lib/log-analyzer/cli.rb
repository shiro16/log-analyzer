require 'command_line_reporter'

module Log::Analyzer
  class CLI
    def self.run(files, options)
      routing_text = File.read(options[:r])
      analyze = Log::Analyzer::Analyze.new(files, routing_text)
      Report.new(analyze.sort).run
    end

    class Report
      include CommandLineReporter

      def initialize(endpoints)
        @endpoints = endpoints
      end

      def run
        table(width: :auto, border: true) do
          row header: true, color: 'red' do
            column('method')
            column('endpoint')
            column('count')
          end
          @endpoints.each do |endpoint|
            row color: 'red' do
              column(endpoint.method)
              column(endpoint.uri_pattern)
              column(endpoint.count)
            end
          end
        end
      end
    end
  end
end
