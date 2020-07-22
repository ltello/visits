#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/analizer'

begin
  stats = Analizer.new(ARGV[0])
rescue Analizer::LogError => e
  puts e.message
  exit(-1)
end

puts "No visits logged" if stats.none?
