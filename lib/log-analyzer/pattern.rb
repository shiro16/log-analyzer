module Log::Analyzer
  class Pattern < ActionDispatch::Journey::Path::Pattern
    attr_accessor :request_method, :uri_pattern

    def self.from_string(request_method, uri_pattern, requirements)
      requirements = if requirements.nil? || requirements.empty?
                       {}
                     else
                       eval(requirements)
                     end
      requirements ||= {}
      new(ActionDispatch::Journey::Router::Strexp.build(uri_pattern, requirements, ["/.?"], true), request_method, uri_pattern)
    end

    def initialize(strexp, request_method, uri_pattern)
      @request_method = request_method
      @uri_pattern = uri_pattern
      super(strexp)
    end
  end
end
