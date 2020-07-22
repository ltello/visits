# frozen_string_literal: true

require_relative 'analizer/log_error'

# Use Analizer class to parse a log file with requests and compute visit statistics.
#   stats = Analizer.new("file.log")
#   stats.visits        #=> { "/users" => 1, ..., "/posts/2": 20 }
#   stats.unique_visits #=> { "/users" => 1, ..., "/posts/2": 9 }
class Analizer
  attr_reader :filename, :visits, :unique_visits

  def initialize(filename)
    @filename = filename
    initialize_stats
    compute_stats
  end

  # No requests logged in the file?
  def none?
    visits.empty?
  end

  private

  attr_reader :requests

  def compute_stats
    File.foreach(filename) do |line|
      endpoint, ip = line.split(" ")
      process_request(endpoint, ip)
    end
  rescue StandardError
    raise LogError
  end

  def initialize_stats
    @requests      = Hash.new { |h, k| h[k] = [] }
    @visits        = Hash.new(0)
    @unique_visits = Hash.new(0)
  end

  def process_request(endpoint, ip)
    visits[endpoint] += 1
    return if requests[endpoint].include?(ip)
    requests[endpoint] << ip
    unique_visits[endpoint] += 1
  end
end
