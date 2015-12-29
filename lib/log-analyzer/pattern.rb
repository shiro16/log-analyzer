module Log::Analyzer
  class Pattern < ActionDispatch::Journey::Path::Pattern
    attr_accessor :uri_pattern

    def self.from_string(string)
      new(ActionDispatch::Journey::Router::Strexp.build(string, {}, ["/.?"], true), string)
    end

    def initialize(strexp, string)
      @uri_pattern = string
      super(strexp)
    end
  end
end
