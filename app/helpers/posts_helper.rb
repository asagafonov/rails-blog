# frozen_string_literal: true

module PostsHelper
  class TimeSince
    class << self
      def amount(created_at)
        time_diff_seconds = Time.current - created_at

        if time_diff_seconds < one_hour_in_seconds
          convert_to_minutes(time_diff_seconds)
        elsif time_diff_seconds < one_day_in_seconds
          convert_to_hours(time_diff_seconds)
        else
          convert_to_days(time_diff_seconds)
        end
      end

      def one_hour_in_seconds
        60 * 60
      end

      def one_day_in_seconds
        60 * 60 * 24
      end

      def convert_to_minutes(diff)
        time = (diff / 1.minute).floor
        format(time, :minute)
      end

      def convert_to_hours(diff)
        time = (diff / 1.hour).floor
        format(time, :hour)
      end

      def convert_to_days(diff)
        time = (diff / 1.day).floor
        format(time, :day)
      end

      def format(time_value, type)
        case type
        when :minute
          I18n.t('time.minute', count: time_value)
        when :hour
          I18n.t('time.hour', count: time_value)
        else
          I18n.t('time.day', count: time_value)
        end
      end
    end
  end
end
