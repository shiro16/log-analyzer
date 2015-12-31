require 'spec_helper'

describe Log::Analyzer::Log do
  describe '#each_line' do
    subject { Log::Analyzer::Log.new(fixtures_path_for("rails.log")) }

    it do
      subject.each_line do |req|
        expect(req).to be_kind_of(ActionDispatch::Request)
      end
    end
  end
end
