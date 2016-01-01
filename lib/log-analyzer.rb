require 'log-analyzer/version'
require 'log-analyzer/config'
require 'log-analyzer/routes'
require 'log-analyzer/analyze'
require 'log-analyzer/log'
require 'log-analyzer/router'
require 'log-analyzer/pattern'
require 'log-analyzer/endpoint'
require 'log-analyzer/rails/railtie.rb' if defined?(Rails)

module Log
  module Analyzer
    module_function
    def self.configure(&block)
      yield(config)
    end

    def config
      @_config ||= Config.new
    end
  end
end
