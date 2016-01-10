require 'spec_helper'

describe Log::Analyzer::Pattern do
  let(:request_method) { "GET" }
  let(:uri_pattern) { "/" }
  let(:requirements) { nil }

  describe '.from_string' do
    subject { Log::Analyzer::Pattern.from_string(request_method, uri_pattern, requirements) }

    it { expect(subject).to be_kind_of(Log::Analyzer::Pattern) }
    it { expect(subject.request_method).to eq(request_method) }
    it { expect(subject.uri_pattern).to eq(uri_pattern) }

    context 'when requirements is nil' do
      it { expect(subject.requirements).to eq({}) }
    end

    context 'when requirements is empty string' do
      let(:requirements) { "" }

      it { expect(subject.requirements).to eq({}) }
    end

    context 'when requirements is string' do
      let(:requirements) { "{ id: /[\\d]+/}" }

      it { expect(subject.requirements).to eq({ id: /[\d]+/}) }
    end
  end
end
