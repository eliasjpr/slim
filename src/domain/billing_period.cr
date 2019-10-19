require "json"

class BillingPeriod
  include JSON::Serializable
  getter start_date : Time
  getter end_date : Time

  def initialize(@start_date, time_span : Time::Span | Time::MonthSpan)
    @end_date = @start_date + time_span
  end

  def range : Range
    start_date..end_date.at_end_of_day
  end

  def count
    (end_date - start_date).days
  end

  def count_by(days : Set(Int32))
    human_days = days.map { |d| Time::DayOfWeek.from_value(d) }
    series.count { |d| human_days.includes? d }
  end

  def series
    (1..count).map do |n|
      (Time.local + n.day).day_of_week
    end
  end
end
