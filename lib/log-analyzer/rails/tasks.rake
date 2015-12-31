namespace :log_analyzer do
  desc 'Analyze the endpoint from the log'
  task analyze: :environment do
    require 'log-analyzer/cli'

    all_routes = Rails.application.routes.routes
    inspector = ActionDispatch::Routing::RoutesInspector.new(all_routes)
    routing_text = inspector.format(ActionDispatch::Routing::ConsoleFormatter.new, ENV['CONTROLLER'])
    analyze = Log::Analyzer::Analyze.new(Rails.root.join("log/#{Rails.env}.log"), routing_text)
    Log::Analyzer::CLI::Report.new(analyze.sort).run
  end
end
