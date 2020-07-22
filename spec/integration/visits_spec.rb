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

describe "When All Visits are unique" do
  let(:printed) do
    <<~PRINTED
      Page Views:
      /help_page/1 5 visits
      /home 3 visits
      /about 1 visit
      /about/2 1 visit
      /contact 1 visit
      /index 1 visit
      -------------------------
      Unique Page Views:
      /help_page/1 5 visits
      /home 3 visits
      /about 1 visit
      /about/2 1 visit
      /contact 1 visit
      /index 1 visit
    PRINTED
  end

  let(:script) { system("./bin/visits.rb fixtures/all_visits_unique.log") }

  it "prints 2 similar sorted lists of visits" do
    expect { script }.to output(printed).to_stdout_from_any_process
    expect(script).to be_truthy
  end
end

describe "When not all Visits are unique" do
  let(:printed) do
    <<~PRINTED
      Page Views:
      /about/2 90 visits
      /contact 89 visits
      /index 82 visits
      /about 81 visits
      /help_page/1 80 visits
      /home 78 visits
      -------------------------
      Unique Page Views:
      /contact 23 visits
      /help_page/1 23 visits
      /home 23 visits
      /index 23 visits
      /about/2 22 visits
      /about 21 visits
    PRINTED
  end

  let(:script) { system("./bin/visits.rb fixtures/all_sort_of_visits.log") }

  it "prints sorted lists of visits" do
    expect { script }.to output(printed).to_stdout_from_any_process
    expect(script).to be_truthy
  end
end
