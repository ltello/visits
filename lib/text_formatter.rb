# frozen_string_literal: true

require_relative 'analizer'

class TextFormatter < SimpleDelegator
  def visits
    @visits ||= sorted_listing(super)
  end

  def unique_visits
    @unique_visits ||= sorted_listing(super)
  end

  private

  def listing(counting, singular: :visit, plural: :visits)
    return "No visits" if counting.empty?
    counting.map do |(endpoint, count)|
      [endpoint, pluralize(count, singular, plural)].join(" ")
    end.join("\n")
  end

  def pluralize(count, singular, plural)
    return "No #{plural}" if count.zero?
    subject = count == 1 ? singular : plural
    [count, subject].join(" ")
  end

  def sorted_counting(counting)
    counting.sort_by { |endpoint, count| [-count, endpoint] }
  end

  def sorted_listing(counting)
    data = sorted_counting(counting)
    listing(data)
  end
end
