require 'active_support/time'

module BusinessTime
  class BusinessDays
    include BusinessTime::Currency
    include Comparable
    attr_reader :days, :currency

    def initialize(days, *currency)
      @days = days
      @currency = args(*currency)
    end
        
    def <=>(other)
      if other.class != self.class
        raise ArgumentError.new("#{self.class.to_s} can't be compared with #{other.class.to_s}")
      end
      self.days <=> other.days
    end

    def after(time = Time.current)
      days = @days
      while days > 0 || !time.workday?(*@currency)
        days -= 1 if time.workday?(*@currency)
        time = time + 1.day
      end
      time
    end

    alias_method :from_now, :after
    alias_method :since, :after

    def before(time = Time.current)
      days = @days
      while days > 0 || !time.workday?(*@currency)
        days -= 1 if time.workday?(*@currency)
        time = time - 1.day
      end
      time
    end

    alias_method :ago, :before
    alias_method :until, :before
  end
end
