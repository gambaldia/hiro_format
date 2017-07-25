# HiroFormat

HiroFormat (hiro_format) is a text formatter.

It converts ruby variables into formatted text by predefined recipe.
It also supports ANSI color display for console applications, and html class handling to have colorful texts.

This formatter uses ruby symbols to specify formats.

It is nice to have a def like "MyString".red , but by using symbols it gives you much more flexibilities to handle data of database objects, arrays, hashes.

See 'Usage hint for Active Record  / Sequel users'


## Still Buggy

Sorry, it is still in very early stage of development. If you use this, please update the gem frequently.

Bug reports are welcome.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hiro_format'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hiro_format

## Usage

~~~ruby
require 'hiro_format'

puts "This is a text string".color(:red_marker).to_s
value = 123456.78
puts value.formatting(:commify).color(:blue).to_s # 123,456.78 (Blue color)
puts value.formatting(:euro_commify).color(:red).to_s # 123.456,78 (Red color)
puts value.formatting(:euro).to_s # € 123.456,78

puts Formatting.new(Date.today, :jp_date).color(:magenta_marker).to_s # 2017-12-24
puts Date.today.formatting(:euro_date).color(:reverse).to_s # 24-12-2017
puts Formatting.new(Date.today, :us_date).color("magenta").to_span # <span class="magenta">12-24-2017</span>
# pzm means Plus/Zero/Minus
puts -1.formatting(:digit6).pzm?(12, [:green, :hide, :red]).to_s # -01 (Green)
puts 0.formatting(:digit6).pzm?(0, [:green, :hide, :red]).to_s #  (No show)
puts 1.formatting(:digit6).pzm([:green, :hide, :red]).to_s # 000002 (Green)
~~~

See formatting_sample.rb for more examples.


## Usage hint for Active Record  / Sequel users

~~~ruby
# For Gem users
require "hiro_format"
# For cloner
#require "./lib/hiro_format/formatting"
#require "./lib/hiro_format/coloring"

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
~~~

## Formatting Recipes

:date, :datetime, :machine_date, :commify, and more

See Help file for details : Formatting.md

## Coloring Recipes

:hide, :red, :red_bold, :red_back, :red_marker, :yellow, :reverse, and more

Run formatting_sample.rb to see a list of supported recipes.


## TODO

Project just started. A lot to do.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gambaldia/hiro_tools.

## Licence

MIT
