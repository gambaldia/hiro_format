#!/usr/bin/env ruby
#
# Formatting Class Usage Example
#
# 2017-07-29 Start
#

APP_ROOT = File.dirname(__FILE__)
$LOAD_PATH << "#{APP_ROOT}/lib"
require "hiro_format/coloring"

puts "This is a text string".color(:red_marker).to_s
puts AnsiColoring.new("This is a text string", :blue_marker).to_s
