#!/usr/bin/env ruby
#
# HiroTools Formatter - AnsiColoring
#
# Hiro Utsumi (Github: Gambaldia)- Zolder Belgium
#
# 2017-07-22 Start
#

  class AnsiColoring

    COLOR_CODES = {
			:black => 0,
			:red => 1,
			:green => 2,
		  :yellow  => 3,
			:blue => 4,
			:magenta => 5,
			:cyan => 6,
			:white => 7,
			:default => 9
		}.freeze
		# Light color = +60
		# Foreground = +30
		# Background = +40
		# DISPLAY_MODES = {:default => 0,:bold => 1,:fainted => 2,:italic => 3,}.freeze
		COLOR_SCHEMES = {
      :black          => "0;30;0",
      :black_red      => "1;31;40",
      :black_yellow   => "1;33;40",
      :black_cyan     => "1;36;40",
      :reverse        => "0;37;40",
			:red            => "0;31;49",
			:red_bold       => "1;31;49",
			:red_back       => "0;37;41",
			:red_marker     => "0;30;101",
			:green          => "0;32;49",
      :green_bold     => "1;32;49",
      :green_back     => "0;37;42",
      :green_marker   => "0;30;102",
			:yellow         => "0;33;49",
      :yellow_bold    => "1;33;49",
      :yellow_back    => "0;30;43",
      :yellow_marker  => "0;30;103",
			:blue           => "0;34;49",
      :blue_bold      => "1;34;49",
      :blue_back      => "0;37;44",
      :blue_marker    => "0;37;104",
			:magenta        => "0;35;49",
      :magenta_bold   => "1;35;49",
      :magenta_back   => "0;37;45",
      :magenta_marker => "0;30;105",
			:cyan           => "0;36;49",
      :cyan_bold      => "1;36;49",
      :cyan_back      => "0;37;46",
      :cyan_marker    => "0;30;106",
			:gray           => "0;37;49",
      :gray_bold      => "1;37;49",
      :gray_back      => "0;30;47",
      :gray_marker    => "0;30;47",
		}.freeze

    def initialize(data, color_scheme)
      @data = data
      @color_scheme = color_scheme
    end

    def to_s
      AnsiColoring.colorize(@data, @color_scheme)
    end

    def self.colorize(data, color_scheme=nil)
      case color_scheme
      when nil?
        data
      when :hide
        ''
      else
        "\033[#{COLOR_SCHEMES[color_scheme]}m#{data}\033[0m"
      end
    end

    def self.show_list
      puts "Color scheme list:"
      COLOR_SCHEMES.each do |key, scheme|
        print AnsiColoring.colorize(key, key)
        print ", "
      end
      puts
    end

  end

  class NilClass
    def color(color_scheme)
      AnsiColoring.new(self, color_scheme)
    end
  end

  class String
    def color(color_scheme)
      AnsiColoring.new(self, color_scheme)
    end
  end


  if (__FILE__ == $0)
    Coloring.show_list
  end
