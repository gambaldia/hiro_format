#!/usr/bin/env ruby
#
# For Gem users
#require "hiro_format"
# For cloner
require "./lib/hiro_format/formatting"
require "./lib/hiro_format/coloring"

# Model class
class MyFriend # < Sequel::Model # < ActiveRecord::Base
  RECORDS = [
    {:id => 1, :name => "John", :bday => Date.parse('1989-01-02'), :assets => 1000000, :gender => 1},
    {:id => 2, :name => "Kevin", :bday => Date.parse('1991-04-12'), :assets => -10000, :gender => 0},
    {:id => 3, :name => "Wendy", :bday => Date.parse('1990-05-12'), :assets => 0, :gender => 2},
  ]
  GENDERS = {
    0 => 'Other',
    1 => 'Male',
    2 => 'Female',
  }
  FIELD_LIST = [
    {:title => "ID", :key => :id, :callback => :edit_button},
    {:title => "Name", :key => :name, :format => :none, :color => "blue_class"},
    {:title => "Gender", :key => :gender, :lookup => GENDERS, },
    {:title => "BirthDay", :key => :bday, :format => :obvious_date, },
    {:title => "Assets", :key => :assets, :format => :euro, :pzm => ["green_class", "blue_class", "red_class"]},
  ]
  attr_reader :data
  def initialize(data)
    @data = data
  end

  def edit_button
    "<input type=\"button\" class=\"btn-sm\" value=\"Edit\" onClick=\"location.href='/controller/edit/#{@data[:id]}'\">"
  end

  def [](key)
    @data[key]
  end

  def self.all
    result = []
    RECORDS.each do |record|
      result << self.new(record)
    end
    result
  end
end

# Controller
@records = MyFriend.all
@field_list = MyFriend::FIELD_LIST

# View can be independent from ModelClass
puts "<table>"
puts "<tr>"
@field_list.each do |field|
  puts "<th>#{field[:title]}</th>"
end
puts "</tr>"
@records.each do |my_friend|
  puts "<tr>"
  @field_list.each do |field|
    if field[:callback]
      puts "<td>" + my_friend.send(field[:callback]) + "</td>"
    elsif field[:lookup]
        puts "<td>" + field[:lookup][my_friend[field[:key]]] + "</td>"
    elsif field[:pzm]
      puts my_friend[field[:key]].formatting(field[:format]).pzm(field[:pzm]).to_td
    else
      puts my_friend[field[:key]].formatting(field[:format]).color(field[:color]).to_td
    end
  end
  puts "</tr>"
end
puts "</table>"
