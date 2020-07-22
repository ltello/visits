# frozen_string_literal: true

require_relative 'analizer/log_error'

class Analizer
  attr_reader :filename

  def initialize(filename)
    @filename = filename
    compute_stats
  end

  private

  def compute_stats
    File.foreach(filename) do |line|
    end
  rescue StandardError
    raise LogError
  end
end
