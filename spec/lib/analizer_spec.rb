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

  describe "#visits" do
    shared_examples "a visits counter" do
      subject(:analizer) { described_class.new(log) }

      it "returns a hash counting the visits" do
        expect(analizer.visits).to eq(expected)
      end
    end

    context "when there are no requests" do
      let(:log) { "fixtures/empty.log" }
      let(:expected) { {} }

      it_behaves_like "a visits counter"
    end

    context "when all requests hit the same endpoint" do
      let(:log) { "fixtures/single_endpoint.log" }
      let(:expected) { { "/help_page/1" => 7 } }

      it_behaves_like "a visits counter"
    end

    context "when requests hit multiple endpoints" do
      let(:log) { "fixtures/multiple_endpoints.log" }
      let(:expected) do
        {
          "/help_page/1" => 4,
          "/contact"     => 1,
          "/about"       => 1,
          "/about/2"     => 2,
          "/index"       => 1,
          "/home"        => 1
        }
      end

      it_behaves_like "a visits counter"
    end
  end
end
