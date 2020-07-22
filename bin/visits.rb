#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/analizer'

begin
  stats = Analizer.new(ARGV[0])
rescue Analizer::LogError => e
  puts e.message
  exit(-1)
end

if stats.none?
  puts "No visits logged"
else
  formatter = StatsFormatter.new(stats)
  puts "Page Views:\n#{formatter.visits}"
  puts "-" * 25
  puts "Unique Page Views:\n#{formatter.unique_visits}"
end
