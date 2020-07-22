# frozen_string_literal: true

describe "When log file cannot be found/read" do
  let(:printed) { "Error loading log file to analize\n" }
  let(:script)  { system("./bin/visits.rb fixtures/nofile.log") }

  it "prints error message and exit failing" do
    expect { script }.to output(printed).to_stdout_from_any_process
    expect(script).to be_falsey
  end
end

describe "When there are no visits logged" do
  let(:printed) { "No visits logged\n" }
  let(:script)  { system("./bin/visits.rb fixtures/empty.log") }

  it "prints no visits message" do
    expect { script }.to output(printed).to_stdout_from_any_process
    expect(script).to be_truthy
  end
end
