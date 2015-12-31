# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'log-analyzer/version'

Gem::Specification.new do |spec|
  spec.name          = "log-analyzer"
  spec.version       = Log::Analyzer::VERSION
  spec.authors       = ["shiro16"]
  spec.email         = ["nyanyanyawan24@gmail.com"]

  spec.summary       = %q{Analyze the performance of each endpoint from the routing file}
  spec.description   = %q{Analyze the performance of each endpoint from the routing file}
  spec.homepage      = "https://github.com/shiro16/log-analyzer"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "actionpack", "~> 4.2.4"
  spec.add_dependency "command_line_reporter"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rails"
  spec.add_development_dependency "sqlite3"
end
