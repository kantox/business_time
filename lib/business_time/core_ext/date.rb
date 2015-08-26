# Add workday and weekday concepts to the Date class
class Date
  include BusinessTime::TimeExtensions

  def business_days_until(to_date, *currency)
    business_dates_until(to_date, *[currency]).size
  end

  def business_dates_until(to_date, *currency)
    currency = currency.flatten
    (self...to_date).select { |day| day.workday?(*[currency]) }
  end
end
