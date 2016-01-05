require 'optparse'
require 'log-analyzer'
require 'log-analyzer/cli'

op = OptionParser.new

opts = {}

op.banner = 'Usage: log-analyzer [options] <file ...>'

op.on('-h', '--help', 'output usage information') do
  puts op
  exit
end

op.on('-V', '--version', 'output the version number') do |v|
  puts Log::Analyzer::VERSION
  exit
end

op.on('-r FILE', 'routing format file') { |v| opts[:routing_file] = v }
op.on('-S VALUE', '--log-separator', 'log separator') { |v| opts[:log_separator] = v }
op.on('-R VALUE', '--route-regexp', 'route regexp') { |v| opts[:route_regexp] = v }
op.on('-L VALUE', '--log-regexp', 'log regexp') { |v| opts[:log_regexp] = v }

op.parse!(ARGV)

if ARGV.empty?
  puts op
else
  Log::Analyzer.configure do |config|
    config.route_regexp = Regexp.new(opts[:route_regexp]) if opts[:route_regexp]
    config.log_regexp   = Regexp.new(opts[:log_regexp]) if opts[:log_regexp]
    config.log_separator = opts[:log_separator] if opts[:log_separator]
  end

  Log::Analyzer::CLI.run(ARGV, opts)
end
