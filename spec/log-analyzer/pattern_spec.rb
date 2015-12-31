require 'spec_helper'

describe Log::Analyzer::Pattern do
  let(:request_method) { "GET" }
  let(:uri_pattern) { "/" }

  describe '.from_string' do
    subject { Log::Analyzer::Pattern.from_string(request_method, uri_pattern) }

    it { expect(subject).to be_kind_of(Log::Analyzer::Pattern) }
    it { expect(subject.request_method).to eq(request_method) }
    it { expect(subject.uri_pattern).to eq(uri_pattern) }
  end
end
