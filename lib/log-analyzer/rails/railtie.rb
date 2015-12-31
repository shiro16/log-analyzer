module Log::Analyzer
  module Rails
    class Railtie < ::Rails::Railtie
      rake_tasks do
        load 'log-analyzer/rails/tasks.rake'
      end
    end
  end
end
