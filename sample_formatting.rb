#!/usr/bin/env ruby
#
# Formatting Class Usage Example
#
# 2017-07-24 Start
#

# Following lines are needed if you clone this from GitHub
APP_ROOT = File.dirname(__FILE__)
$LOAD_PATH << "#{APP_ROOT}/lib"
require "hiro_format/formatting"
require "hiro_format/coloring"

values = [1234567890.1234, 0]
values.each do |value|
  puts "Value: #{value}"
  print ":commify: "
  puts value.formatting(:commify).color(:blue).to_s
  print ":euro_commify: "
  puts value.formatting(:euro_commify).color(:red).to_s
  print ":commify0: "
  puts value.formatting(:commify0).color(:blue).to_s
  print ":euro_commify0: "
  puts value.formatting(:euro_commify0).color(:red).to_s
  print ":commify4: "
  puts value.formatting(:commify4).color(:blue).to_s
  print ":euro_commify4: "
  puts value.formatting(:euro_commify4).color(:red).to_s
end

puts "12345".formatting(:japanese_yen).color(:green).to_s
puts "12345".formatting(:euro).color(:green).to_s

puts Formatting.new(Date.today, :us_date).color(:magenta_marker).to_s
puts Date.today.formatting(:euro_date).color(:reverse).to_s
puts Date.today.formatting(:machine_date).color(:cyan_bold).to_s
puts "#pzm (Plus, Zero, Minus) can show in different color depending on the value passed."
[-1, 0, 1].each do |n|
  print "#{n.class}: "
  puts n.formatting(:digit6).pzm([:reverse, :red_marker, :magenta_marker]).to_s
end
puts "Formatting helper for HTML, you set your color in CSS (Cyan Marker)".color(:cyan_marker).to_s
puts Formatting.new(Date.today, :us_date).color("magenta").to_span # <span class="magenta">12-24-2017</span>

AnsiColoring.show_list
