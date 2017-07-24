#!/usr/bin/env ruby
#
# HiroTools Formatter
#
# Hiro Utsumi (Github: Gambaldia)- Zolder Belgium
#
# 2017-07-22 Start
#
require 'date'

	class Formatting
		YOUBI = %w[日 月 火 水 木 金 土]
    FORMATTER_LIST = {
			:date => {:time_format => "%Y-%m-%d", :applicable => [Date, DateTime], :rest => "0000-00-00" },
      :jp_date => {:time_format => "%Y-%m-%d", :applicable => [Date, DateTime], :rest => "0000-00-00" },
      :us_date => {:time_format => "%m-%d-%Y", :applicable => [Date, DateTime], :rest => "0000-00-00" },
      :euro_date => {:time_format => "%d-%m-%Y", :applicable => [Date, DateTime], :rest => "0000-00-00" },
      :obvious_date => {:time_format => "%d-%b-%Y", :applicable => [Date, DateTime], :rest => "0000-00-00" },
      :machine_date => {:time_format => "%Y%m%d", :applicable => [Date, DateTime], :rest => "00000000" },

			:datewday => {:time_format => "%Y-%m-%d (%a)", :applicable => [Date, DateTime], :rest => "0000-00-00 (---)" },
			:jp_datewday => {:time_format => "%Y-%m-%d (%a)", :applicable => [Date, DateTime], :rest => "0000-00-00 (---)" },
			:us_datewday => {:time_format => "%m-%d-%Y (%a)", :applicable => [Date, DateTime], :rest => "00-00-0000 (---)" },
			:euro_datewday => {:time_format => "%d-%m-%Y (%a)", :applicable => [Date, DateTime], :rest => "00-00-0000 (---)" },

			:datetime => {:time_format => "%Y-%m-%d %H:%M", :applicable => [Date, DateTime, Time], :rest => "0000-00-00" },
			:datetimesecond => {:time_format => "%Y-%m-%d %H:%M%s", :applicable => [Date, DateTime, Time], :rest => "0000-00-00" },
			:jp_datetime => {:time_format => "%Y-%m-%d %H:%M", :applicable => [Date, DateTime, Time], :rest => "0000-00-00" },
			:jp_datetimesecond => {:time_format => "%Y-%m-%d %H:%M:%s", :applicable => [Date, DateTime, Time], :rest => "0000-00-00 00:00:00" },
			:us_datetime => {:time_format => "%m-%d-%Y %H:%M", :applicable => [Date, DateTime, Time], :rest => "00-00-0000  00:00" },
			:us_datetimesecond => {:time_format => "%m-%d-%Y %H:%M:%s", :applicable => [Date, DateTime, Time], :rest => "00-00-0000 00:00:00" },
			:euro_datetime => {:time_format => "%d-%m-%Y %H:%M", :applicable => [Date, DateTime, Time], :rest => "00-00-0000 00:00" },
			:euro_datetimesecond => {:time_format => "%d-%m-%Y %H:%M:%s", :applicable => [Date, DateTime, Time], :rest => "0000-00-00 00:00:00" },
      :machine_datetime => {:time_format => "%Y%m%d%H%M", :applicable => [Date, DateTime], :rest => "000000000000" },

      :digit6 =>{:format => "%06d", :applicable => [Fixnum, Integer, Float], :rest => "000000"},
      :digit2 =>{:format => "%02d", :applicable => [Fixnum, Integer, Float], :rest => "00"},

      :func =>{:function => "", :applicable => [], :rest => ""},
		}.freeze

    def initialize(data, formatting_option=nil)
      @data = data
      @formatting_option = formatting_option
    end

    def color(color_scheme)
      @color_scheme = color_scheme
			self
    end

    def pzm(plus, zero, minus)
      judge = @data.to_f
      if judge > 0.0
        @color_scheme = plus
      elsif judge < 0.0
        @color_scheme = minus
      else
        @color_scheme = zero
      end
			self
    end

		def pzm?(judge, plus, zero, minus)
      judge = judge.to_f
      if judge > 0.0
        @color_scheme = plus
      elsif judge < 0.0
        @color_scheme = minus
      else
        @color_scheme = zero
      end
			self
    end

		def yesno?(yes, no)
      if @data
        @color_scheme = yes
      else
        @color_scheme = no
      end
			self
    end


    def yesno(judge, yes, no)
      if judge
        @color_scheme = yes
      else
        @color_scheme = no
      end
			self
    end

		def to_string
			if @formatting_option.nil?
        #result = @data.to_s
      elsif recipe = FORMATTER_LIST[@formatting_option]
				# puts @data.class
        if recipe[:applicable].include?(@data.class)
          if recipe[:time_format]
            result = @data.strftime(recipe[:time_format])
          elsif recipe[:format]
            result = recipe[:format] % @data
          elsif recipe[:function]
            Formatting.send(recipe[:function], @data)
          end
        else
          result = recipe[:rest]
        end
      end
      result || @data.to_s
		end

    def to_s
			result = to_string
			if @color_scheme && AnsiColoring
				result = AnsiColoring.colorize(result, @color_scheme)
			end
      result
    end
    alias show to_s

		def to_tag(tag="div")
			case @color_scheme
      when :hide
        content = ''
      else
				result = "<#{tag} class=\"#{@color_scheme}\">#{to_string}</#{tag}>"
      end
		end

		def to_div
			to_tag("div")
		end

		def to_span
			to_tag("span")
		end

		def to_td
			to_tag("td")
		end

		def self.commify(num)
			int, frac = *num.split(".")
			int = int.gsub(/(\d)(?=\d{3}+$)/, '\\1,')
			int << "." << frac if frac
			int
		end

	end

	class NilClass
		def formatting(option=nil)
      Formatting.new(self, option)
    end
  end

  class String
    def formatting(option=nil)
      Formatting.new(self, option)
    end

    def commify
      self.gsub(/(\d)(?=\d{3}+$)/, '\\1,')
    end
  end

  class Date
    def formatting(option=nil)
      Formatting.new(self, option)
    end
  end

  class Time
    def formatting(option=nil)
      Formatting.new(self, option)
    end
  end

  class DateTime
    def formatting(option=nil)
      Formatting.new(self, option)
    end
  end

  class Integer
    def formatting(option=nil)
      Formatting.new(self, option)
    end

    def commify
      self.to_s.commify
    end
  end

  class Float
    def formatting(option=nil)
      Formatting.new(self, option)
    end

    def commify
      Formatting.commify(self.to_s)
    end
  end

  class BigDecimal
    def formatting(option=nil)
      Formatting.new(self, option)
    end
  end
