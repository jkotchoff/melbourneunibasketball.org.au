Date::DATE_FORMATS.merge!(:month_day_year => lambda { |time| time.strftime("%B #{time.day.ordinalize}, %Y") })
Time::DATE_FORMATS.merge!(:month_day_year => lambda { |time| time.strftime("%B #{time.day.ordinalize}, %Y") })

Date::DATE_FORMATS.merge!(year: "%Y")
Time::DATE_FORMATS.merge!(year: "%Y")

Date::DATE_FORMATS.merge!(:abbr_month_day_year => lambda { |time| time.strftime("%b #{time.day.ordinalize}, %Y") })
Time::DATE_FORMATS.merge!(:abbr_month_day_year => lambda { |time| time.strftime("%b #{time.day.ordinalize}, %Y") })

Time::DATE_FORMATS.merge!(:file_timestamp => "%Y-%m-%d_%H.%M%P")
