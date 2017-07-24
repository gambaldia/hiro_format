#!/usr/bin/env ruby
#
# require "hiro_format" # you need gem install hiro_format
require "./lib/hiro_format/formatting"
require "./lib/hiro_format/coloring"

FIELD_LIST = [
  {:title => "ID", :key => :id, :format => nil},
  {:title => "Name", :key => :name, :format => :none, :color => "blue_class"},
  {:title => "BirthDay", :key => :bday, :format => :obvious_date, },
  {:title => "Assets", :key => :assets, :format => :euro, :pzm => ["green_class", "blue_class", "red_class"]},
]
# @records = MyFriend.all
# For test without database engine
@records = [
  {:id => 1, :name => "John", :bday => Date.parse('2000-01-02'), :assets => '1000000'},
  {:id => 2, :name => "Kevin", :bday => Date.parse('2000-04-12'), :assets => '-10000'},
]
puts "<table>"
puts "<tr>"
FIELD_LIST.each do |field|
  puts "<th>#{field[:title]}</th>"
end
puts "</tr>"
@records.each do |my_friend|
  puts "<tr>"
  FIELD_LIST.each do |field|
    if field[:pzm]
      puts my_friend[field[:key]].formatting(field[:format]).pzm(field[:pzm]).to_td
    else
      puts my_friend[field[:key]].formatting(field[:format]).color(field[:color]).to_td
    end
  end
  puts "</tr>"
end
puts "</table>"
