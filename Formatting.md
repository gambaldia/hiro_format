# Supported Recipes

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
    :digit6 =>{:format => "%06d", :applicable => [Fixnum, Integer, Float], :rest => "000000"},
    :digit2 =>{:format => "%02d", :applicable => [Fixnum, Integer, Float], :rest => "00"},

    :commify =>{:function => "commify", :applicable => [Integer, Float, String, NilClass], :rest => ""},
    :euro_commify =>{:function => "euro_commify", :applicable => [Integer, Float, String, NilClass], :rest => ""},

  }.freeze
