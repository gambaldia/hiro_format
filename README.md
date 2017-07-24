# HiroFormat

HiroFormat (hiro_format) is a text formatter.

It converts ruby variables into formatted text by predefined recipe.
It also supports ANSI color display for console applications, and html class handling to have colorful texts.

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

## Usage samples

~~~ruby
require 'hiro_format'

puts "This is a text string".color(:red_marker).to_s
value = 123456.78
puts value.formatting(:commify).color(:blue).to_s # 123,456.78 (Blue color)
puts value.formatting(:euro_commify).color(:red).to_s # 123.456,78 (Red color)
puts Formatting.new(Date.today, :jp_date).color(:magenta_marker).to_s # 2017-12-24
puts Date.today.formatting(:euro_date).color(:reverse).to_s # 24-12-2017
puts Formatting.new(Date.today, :us_date).color("magenta").to_span # <span class="magenta">12-24-2017</span>
# pzm means Plus/Zero/Minus
puts -1.formatting(:digit2).pzm?(:green, :hide, :red).to_s # -01 (Red)
puts 0.formatting(:digit2).pzm?(:green, :hide, :red).to_s #  (No show)
puts 1.formatting(:digit6).pzm(value, :green, :hide, :red).to_s # 000002 (Green)
~~~

## Formatting Recipes

:date, :datetime, :machine_date, :commify, and more

See Help file for details at : (TODO)

## Coloring Recipes

:hide, :red, :red_bold, :red_back, :red_marker, :yellow, :reverse, and more

See Help file for details at : (TODO)

## TODO

Project just started. A lot to do.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gambaldia/hiro_tools.

## Licence

MIT
