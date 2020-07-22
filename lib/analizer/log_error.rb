# frozen_string_literal: true

class Analizer
  class LogError < StandardError
    def message
      "Error loading log file to analize"
    end
  end
end
