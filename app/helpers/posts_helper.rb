# frozen_string_literal: true

module PostsHelper
  class TimeSince
    class << self
      def amount(created_at)
        time_diff_seconds = Time.current - created_at
        if time_diff_seconds < 60 * 60
          time = (time_diff_seconds / 1.minute).floor
          format(time, :minute)
        elsif time_diff_seconds < 60 * 60 * 24
          time = (time_diff_seconds / 1.hour).floor
          format(time, :hour)
        else
          time = (time_diff_seconds / 1.day).floor
          format(time, :day)
        end
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
