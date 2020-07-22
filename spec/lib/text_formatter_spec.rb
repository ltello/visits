# frozen_string_literal: true

describe TextFormatter do
  describe "#unique_visits" do
    shared_examples "a unique visits formatter" do
      let(:analizer) { Analizer.new(log) }
      subject(:formatter) { described_class.new(analizer) }

      it "returns a hash counting the visits" do
        expect(formatter.unique_visits).to eq(expected)
      end
    end

    context "when there are no requests" do
      let(:log) { "fixtures/empty.log" }
      let(:expected) { "No visits" }

      it_behaves_like "a unique visits formatter"
    end

    context "when all requests hit the same endpoint" do
      let(:log) { "fixtures/single_endpoint.log" }
      let(:expected) { "/help_page/1 5 visits" }

      it_behaves_like "a unique visits formatter"
    end

    context "when requests hit multiple endpoints" do
      let(:log) { "fixtures/multiple_endpoints.log" }
      let(:expected) do
        <<~PRINTED.chomp
          /help_page/1 4 visits
          /about 1 visit
          /about/2 1 visit
          /contact 1 visit
          /home 1 visit
          /index 1 visit
        PRINTED
      end

      it_behaves_like "a unique visits formatter"
    end
  end

  describe "#visits" do
    shared_examples "a visits formatter" do
     let(:analizer) { Analizer.new(log) }
     subject(:formatter) { described_class.new(analizer) }

     it "returns a hash counting the visits" do
       expect(formatter.visits).to eq(expected)
     end
   end

    context "when there are no requests" do
      let(:log) { "fixtures/empty.log" }
      let(:expected) { "No visits" }

      it_behaves_like "a visits formatter"
    end

    context "when all requests hit the same endpoint" do
      let(:log) { "fixtures/single_endpoint.log" }
      let(:expected) { "/help_page/1 7 visits" }

      it_behaves_like "a visits formatter"
    end

    context "when requests hit multiple endpoints" do
      let(:log) { "fixtures/multiple_endpoints.log" }
      let(:expected) do
        <<~PRINTED.chomp
          /help_page/1 4 visits
          /about/2 2 visits
          /about 1 visit
          /contact 1 visit
          /home 1 visit
          /index 1 visit
        PRINTED
      end

      it_behaves_like "a visits formatter"
    end
  end
end
