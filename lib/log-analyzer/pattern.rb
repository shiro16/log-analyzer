module Log::Analyzer
  class Pattern < ActionDispatch::Journey::Path::Pattern
    attr_accessor :request_method, :uri_pattern

    def self.from_string(request_method, uri_pattern)
      new(ActionDispatch::Journey::Router::Strexp.build(uri_pattern, {}, ["/.?"], true), request_method, uri_pattern)
    end

    def initialize(strexp, request_method, uri_pattern)
      @request_method = request_method
      @uri_pattern = uri_pattern
      super(strexp)
    end
  end
end
