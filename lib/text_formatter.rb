# frozen_string_literal: true

require_relative 'analizer'

# Decorator class for Analizer instances
# Overide statistics methods (#visits, #unique_visits) to return text representations of the counterpart analizer.
# Ex:
#   stats = Analizer.new("file.log")
#   stats.visits #=> { "/users" => 1, ..., "/posts/2": 20 }
#   formatter = TextFormatter(stats)
#   formatter.visits #=> %Q{
#      /posts/2: 20 visits
#      /users: 1 visit
#   }
class TextFormatter < SimpleDelegator
  def visits
    @visits ||= sorted_listing(super)
  end

  def unique_visits
    @unique_visits ||= sorted_listing(super)
  end

  private

  # Returns the text format of a counting hash { e1: count1, ..., en: countn }:
  #   listing({ "/users" => 1, ..., "/posts/2": 20 }) #=> %Q{
  #      /posts/2: 20 visits
  #      /users: 1 visit
  # }
  def listing(counting, singular: :visit, plural: :visits)
    return "No visits" if counting.empty?
    counting.map do |(endpoint, count)|
      [endpoint, pluralize(count, singular, plural)].join(" ")
    end.join("\n")
  end

  # Humanize the input like this:
  #   pluralize(0, :visit, :visits) #=> "No visits"
  #   pluralize(1, :visit, :visits) #=> "1 visit"
  #   pluralize(2, :visit, :visits) #=> "2 visit"
  def pluralize(count, singular, plural)
    return "No #{plural}" if count.zero?
    subject = count == 1 ? singular : plural
    [count, subject].join(" ")
  end

  # Sorts a counting hash { e1: count1, ..., en: countn } based on descending count and alphabetic order
  def sorted_counting(counting)
    counting.sort_by { |endpoint, count| [-count, endpoint] }
  end

  # Sorts the visits counting hash and outputs the result as text
  def sorted_listing(counting)
    data = sorted_counting(counting)
    listing(data)
  end
end
