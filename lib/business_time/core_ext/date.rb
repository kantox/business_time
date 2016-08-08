# Add workday and weekday concepts to the Date class
class Date
  include BusinessTime::TimeExtensions
  include BusinessTime::Currency

  def business_days_until(to_date, inclusive = false, *currency)
    currency = args(*currency)
    business_dates_until(to_date, inclusive, *currency).size
  end

  def business_dates_until(to_date, inclusive = false, *currency)
    currency = args(*currency)
    if inclusive
      (self..to_date).select { |day| day.workday?(*currency) }
    else
      (self...to_date).select { |day| day.workday?(*currency) }
    end
  end
end
