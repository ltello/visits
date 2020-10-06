# frozen_string_literal: true

require_relative 'analizer/log_error'

# Use Analizer class to parse a log file with requests and compute visit statistics.
#   stats = Analizer.new("file.log")
#   stats.visits        #=> { "/users" => 1, ..., "/posts/2": 20 }
#   stats.unique_visits #=> { "/users" => 1, ..., "/posts/2": 9 }
class Analizer
  attr_reader :filename, :visits, :unique_visits, :average_visits

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

  attr_reader :ips

  def compute_average_stats
    @average_visits = visits.keys.inject({}) do |result, endpoint|
      result.merge!(endpoint => visits[endpoint] / unique_visits[endpoint])
    end
  end

  def compute_stats
    File.foreach(filename) do |line|
      endpoint, ip = line.split(" ")
      process_request(endpoint, ip)
    end
    compute_average_stats
  rescue StandardError
    raise LogError
  end

  def count_unique_visit(endpoint, ip)
    ips[endpoint].add(ip)
    unique_visits[endpoint] += 1
  end

  def count_visit(endpoint)
    visits[endpoint] += 1
  end

  def initialize_stats
    @ips           = Hash.new { |h, k| h[k] = Set[] }
    @visits        = Hash.new(0)
    @unique_visits = Hash.new(0)
  end

  def new_endpoint_ip?(endpoint, ip)
    !ips[endpoint].include?(ip)
  end

  def process_request(endpoint, ip)
    count_visit(endpoint)
    count_unique_visit(endpoint, ip) if new_endpoint_ip?(endpoint, ip)
  end
end
