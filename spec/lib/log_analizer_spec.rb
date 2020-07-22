# frozen_string_literal: true

describe Analizer do
  subject(:analizer) { described_class.new(log) }

  context "When log file can't be found" do
    let(:log) { "nofile" }

    it "raises a LogError exception" do
      expect { analizer }.to raise_error(described_class::LogError)
    end
  end

  describe "#none?" do
    let(:result) { analizer.none? }

    context "when log file is empty" do
      let(:log) { "fixtures/empty.log" }

      it "return true" do
        expect(analizer.none?).to be_truthy
      end
    end
  end
end
