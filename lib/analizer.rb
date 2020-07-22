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

  def compute_stats
    File.foreach(filename) do |line|
    end
  rescue StandardError
    raise LogError
  end

  def initialize_stats
    @visits        = Hash.new(0)
    @unique_visits = Hash.new(0)
  end
end
