require 'spec_helper'

describe Log::Analyzer::Endpoint do
  let(:method) { "GET" }
  let(:uri_pattern) { "/" }

  after do
    Log::Analyzer::Endpoint.instance_variable_set(:@endpoints, {})
  end

  describe '.create' do
    subject { Log::Analyzer::Endpoint.create(method: method, uri_pattern: uri_pattern) }

    it { expect(subject).to be_kind_of(Log::Analyzer::Endpoint) }
    it { expect(subject.method).to eq(method) }
    it { expect(subject.uri_pattern).to eq(uri_pattern) }
  end

  describe '.find_by' do
    before do
      Log::Analyzer::Endpoint.create(method: method, uri_pattern: uri_pattern)
      Log::Analyzer::Endpoint.create(method: "POST", uri_pattern: "/")
    end

    subject { Log::Analyzer::Endpoint.find_by(method: method, uri_pattern: uri_pattern) }

    it { expect(subject).to be_kind_of(Log::Analyzer::Endpoint) }
    it { expect(subject.method).to eq(method) }
    it { expect(subject.uri_pattern).to eq(uri_pattern) }
  end

  describe '.all' do
    before do
      Log::Analyzer::Endpoint.create(method: method, uri_pattern: uri_pattern)
      Log::Analyzer::Endpoint.create(method: "POST", uri_pattern: "/")
    end

    subject { Log::Analyzer::Endpoint.all }

    it { expect(subject.count).to eq(2) }
  end

  describe '.endpoints' do
    before do
      Log::Analyzer::Endpoint.create(method: method, uri_pattern: uri_pattern)
    end

    subject { Log::Analyzer::Endpoint.endpoints }

    it { expect(subject.has_key?("#{method}:#{uri_pattern}") ).to be_truthy }
  end
end
