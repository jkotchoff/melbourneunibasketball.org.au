Date::DATE_FORMATS.merge!(:month_day_year => lambda { |time| time.strftime("%B #{time.day.ordinalize}, %Y") })
Time::DATE_FORMATS.merge!(:month_day_year => lambda { |time| time.strftime("%B #{time.day.ordinalize}, %Y") })
