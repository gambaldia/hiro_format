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

			# Fixnum is deprecated in Ruby > 2.4.0 should be removed soon.
      :digit6 => {:format => "%06d", :applicable => [Fixnum, Integer, Float], :rest => "000000"},
      :digit2 => {:format => "%02d", :applicable => [Fixnum, Integer, Float], :rest => "00"},

      :commify => {:function => "commify", :applicable => [Integer, Float, String, NilClass], :rest => ""},
			:euro_commify => {:function => "euro_commify", :applicable => [Integer, Float, String, NilClass], :rest => ""},
			:commify0 => {:function => "commify0", :applicable => [Integer, Float, String, NilClass], :rest => ""},
			:euro_commify0 => {:function => "euro_commify0", :applicable => [Integer, Float, String, NilClass], :rest => ""},
			:commify4 => {:function => "commify4", :applicable => [Integer, Float, String, NilClass], :rest => ""},
			:euro_commify4 => {:function => "euro_commify4", :applicable => [Integer, Float, String, NilClass], :rest => ""},

			:japanese_yen => {:function => "japanese_yen", :applicable => [Integer, Float, String, NilClass], :rest => ""},
			:euro => {:function => "euro", :applicable => [Integer, Float, String, NilClass], :rest => ""},

			:hide => {:format => "", :applicable => [], :rest => ""},
		}.freeze

    def initialize(data, formatting_option=nil)
      @data = data
      @formatting_option = formatting_option
    end

    def color(color_scheme)
      @color_scheme = color_scheme
			self
    end

    def pzm(plus_zero_minus)
			pzm?(@data, plus_zero_minus)
			self
    end

		def pzm?(judge, plus_zero_minus)
      judge = judge.to_f
      if judge > 0.0
        @color_scheme = plus_zero_minus[0]
      elsif judge < 0.0
        @color_scheme = plus_zero_minus[2]
      else
        @color_scheme = plus_zero_minus[1]
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
            result = Formatting.send(recipe[:function], @data)
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

		def to_tag(tag="div", klass=nil)
			klass = @color_scheme unless klass
			if klass
				result = "<#{tag} class=\"#{klass}\">#{to_string}</#{tag}>"
			else
				result = "<#{tag}>#{to_string}</#{tag}>"
      end
			result
		end

		def to_div(klass=nil)
			klass = @color_scheme unless klass
			to_tag("div", klass)
		end

		def to_span(klass=nil)
			klass = @color_scheme unless klass
			to_tag("span", klass)
		end

		def to_td(klass=nil)
			klass = @color_scheme unless klass
			to_tag("td", klass)
		end

		def self.commify_string(num, thousand_sparator=',', decimal_separator='.', decimal=0)
			int, frac = *num.split(".")
			int = int.gsub(/(\d)(?=\d{3}+$)/, "\\1#{thousand_sparator}")
			if decimal > 0
				int << "#{decimal_separator}"
				#if frac
					frac = "#{frac}000000"
					int << frac[0..(decimal-1)]
				#else
				#	""
				#end
			end
			int
		end

		def self.commify_value(data, thousand_sparator=',', decimal_separator='.', decimal=0 )
			case data.class.to_s
			when 'Float'
				return Formatting.commify_string(data.to_s, thousand_sparator, decimal_separator, decimal)
			when 'Integer'
				return Formatting.commify_string(data.to_s, thousand_sparator, decimal_separator, decimal)
			when 'String'
				return Formatting.commify_string(data, thousand_sparator, decimal_separator, decimal)
			when 'NilClass'
				if decimal == 0
					return "0"
				else
					res = "0#{decimal_separator}00000000000"
					return res[0..(decimal+1)]
				end
			else
				return "#{num.class}"
			end
		end

		def self.commify(data)
			Formatting.commify_value(data, ',', '.', 2)
		end

		def self.euro_commify(data)
			Formatting.commify_value(data, '.', ',', 2)
		end

		def self.commify0(data)
			Formatting.commify_value(data, ',', '.', 0)
		end

		def self.euro_commify0(data)
			Formatting.commify_value(data, '.', ',', 0)
		end

		def self.commify4(data)
			Formatting.commify_value(data, ',', '.', 4)
		end

		def self.euro_commify4(data)
			Formatting.commify_value(data, '.', ',', 4)
		end

		def self.japanese_yen(data)
			"¥ " + Formatting.commify_value(data, ',', '.', 0)
		end

		def self.euro(data)
			"€" + Formatting.commify_value(data, '.', ',', 2)
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
