require 'spec_helper'

describe Log::Analyzer::Analyze do
  let(:files) { fixtures_path_for("rails.log") }
  let(:routes_text) { File.read(fixtures_path_for("routes.txt")) }

  describe '#initialize' do
    subject { Log::Analyzer::Analyze.new(files, routes_text) }

    context 'when files is String' do
      let(:files) { fixtures_path_for("rails.log") }

      it { expect(subject.instance_variable_get(:@files)).to eq([fixtures_path_for("rails.log")]) }
    end

    context 'when files is Array' do
      let(:files) { [fixtures_path_for("rails.log")] }

      it { expect(subject.instance_variable_get(:@files)).to eq([fixtures_path_for("rails.log")]) }
    end

    context 'when files is Wildcard String' do
      let(:files) { fixtures_path_for("*.log") }

      it { expect(subject.instance_variable_get(:@files)).to eq([fixtures_path_for("rails.log")]) }
    end

    it do
      expect_any_instance_of(Log::Analyzer::Analyze).to receive(:create_endpoints)
      subject
    end
  end

  describe '.result' do
    let(:analyze) { Log::Analyzer::Analyze.new(files, routes_text) }

    subject { analyze.result }

    it { expect(subject.count).to eq(8) }
  end

  describe '.sort' do
    let(:analyze) { Log::Analyzer::Analyze.new(files, routes_text) }

    subject { analyze.sort }

    it { expect(subject.count).to eq(8) }
    it { expect(subject).to eq(analyze.result.sort{ |a, b| b.count <=> a.count }) }
  end

  describe 'private methods' do
    describe '.match' do
      let(:analyze) { Log::Analyzer::Analyze.new(files, routes_text) }

      before do
        analyze.send(:matche)
      end

      it do
        endpoint = Log::Analyzer::Endpoint.find_by(method: "GET", uri_pattern: "/")
        expect(endpoint.count).to eq(2)
        endpoint = Log::Analyzer::Endpoint.find_by(method: "GET", uri_pattern: "/users(.:format)")
        expect(endpoint.count).to eq(2)
        endpoint = Log::Analyzer::Endpoint.find_by(method: "GET", uri_pattern: "/users/:id(.:format)")
        expect(endpoint.count).to eq(1)
        endpoint = Log::Analyzer::Endpoint.find_by(method: "DELETE", uri_pattern: "/users/:id(.:format)")
        expect(endpoint.count).to eq(1)
        endpoint = Log::Analyzer::Endpoint.find_by(method: "POST", uri_pattern: "/users(.:format)")
        expect(endpoint.count).to eq(1)
      end

      context 'when not called routing' do
        it do
          endpoint = Log::Analyzer::Endpoint.find_by(method: "PUT", uri_pattern: "/users/:id(.:format)")
          expect(endpoint.count).to eq(0)
        end
      end

      context 'when not defined routing' do
        it do
          endpoint = Log::Analyzer::Endpoint.find_by(method: "GET", uri_pattern: "/test")
          expect(endpoint).to be_nil
        end
      end
    end
  end
end
