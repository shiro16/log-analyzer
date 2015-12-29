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

op.on('-r VALUE', 'routing format file') { |v| opts[:r] = v }

op.parse!(ARGV)

if ARGV.empty?
  puts op
else
  Log::Analyzer::CLI.run(ARGV, opts)
end
