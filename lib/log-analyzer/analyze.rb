module Log::Analyzer
  class Analyze
    def initialize(files, routes_text)
      routes = Log::Analyzer::Routes.new(routes_text)
      mapper = Log::Analyzer::Mapper.new(routes)
      files.each do |file|
        log = Log::Analyze::Log.new(file)
        log.each_line do |req|
          next unless matche = mapper.serve(req)
          
        end
      end
    end
  end
end
