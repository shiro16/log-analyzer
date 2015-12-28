module Log::Analyzer
  class Pattern < ActionDispatch::Journey::Path::Pattern
    attr_accessor :uri_pattern

    def self.from_string(string)
      @uri_pattern = string
      super
    end
  end
end
