module Icalendar
  class Event < Component
    optional_property :partstat
    optional_property :mailto
  end
end

module Icalendar
  module Values

    class DateTime < Value
      include TimeWithZone

#      FORMAT = '%Y%m%dT%H%M%S'

      def initialize(value, params = {})
        if value.is_a? String
          params['tzid'] = 'UTC' if value.end_with? 'Z'
          if value.length == 8
            format = '%Y%m%d'
          else
            format = FORMAT
          end
          super ::DateTime.strptime(value, format), params
        elsif value.respond_to? :to_datetime
          super value.to_datetime, params
        else
          super
        end
      end

      def value_ical
        if tz_utc
          "#{strftime FORMAT}Z"
        else
          strftime FORMAT
        end
      end

    end

  end
end