# frozen_string_literal: true

require_relative 'analizer/log_error'

class Analizer
  attr_reader :filename, :visits, :unique_visits

  def initialize(filename)
    @filename = filename
    initialize_stats
    compute_stats
  end

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
  end
end
