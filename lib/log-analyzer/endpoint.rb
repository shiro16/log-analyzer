module Log::Analyzer
  class Endpoint
    attr_accessor :method, :uri_pattern, :count, :values

    def initialize(method: "", uri_pattern: "")
      @method      = method
      @uri_pattern = uri_pattern
      @count       = 0
      @values      = {}
    end

    def [](key)
      @values[key] ||= Value.new
    end

    def self.create(method: "", uri_pattern: "")
      endpoints["#{method}:#{uri_pattern}"] = self.new(method: method, uri_pattern: uri_pattern)
    end

    def self.find_by(method: "", uri_pattern: "")
      endpoints["#{method}:#{uri_pattern}"]
    end

    def self.all
      self.endpoints.values
    end

    def self.endpoints
      @endpoints ||= {}
    end

    class Value
      attr_accessor :total, :min, :max

      def initialize
        @total = 0
        @min   = 0
        @max   = 0
      end

      def min=(value)
        @min = value if @min > value
      end

      def max=(value)
        @max = value if @max < value
      end

      def store(value)
        self.total += value
        self.min = value
        self.max = value
      end
    end
  end
end
