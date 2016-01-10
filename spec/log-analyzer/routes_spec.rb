require 'spec_helper'

describe Log::Analyzer::Routes do
  describe '.initialize' do
    let(:routes_text) { File.read(fixtures_path_for("routes.txt")) }

    subject { Log::Analyzer::Routes.new(routes_text) }

    it { expect(subject.routes.count).to eq(10) }
  end
end
