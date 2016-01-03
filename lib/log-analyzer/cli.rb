require 'command_line_reporter'

module Log::Analyzer
  class CLI
    def self.run(files, options)
      routing_text = File.read(options[:routing_file])
      analyze = Analyze.new(files, routing_text)
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
            @endpoints.first.values.keys.each do |key|
              column("#{key}(avg)")
              column("#{key}(max)")
              column("#{key}(min)")
            end
          end
          @endpoints.each do |endpoint|
            row color: 'red' do
              column(endpoint.method)
              column(endpoint.uri_pattern)
              column(endpoint.count)
              endpoint.values.each do |_, val|
                column(val.inject(0.0, :+).quo(val.count).round(2))
                column(val.max)
                column(val.min)
              end
            end
          end
        end
      end
    end
  end
end
