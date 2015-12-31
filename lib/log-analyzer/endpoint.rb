module Log::Analyzer
  class Endpoint
    attr_accessor :method, :uri_pattern, :count, :values

    def initialize(method:, uri_pattern:, values: Hash.new(0))
      @method      = method
      @uri_pattern = uri_pattern
      @count       = 0
      @values      = values
    end

    def self.create(method:, uri_pattern:)
      endpoints["#{method}:#{uri_pattern}"] = self.new(method: method, uri_pattern: uri_pattern)
    end

    def self.find_by(method:, uri_pattern:)
      endpoints["#{method}:#{uri_pattern}"]
    end

    def self.all
      @endpoints.values
    end

    def self.endpoints
      @endpoints ||= {}
    end
  end
end