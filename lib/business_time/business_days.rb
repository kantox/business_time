require 'active_support/time'

module BusinessTime
  class BusinessDays
    include Comparable
    attr_reader :days, :currency

    def initialize(days, *currency)
      @days = days
      
      currency = currency.flatten
      @currency =   case currency.length
                    when 0
                      nil
                    when 1
                      arg = currency[0]
                      case arg.length
                      when 3 #e.g. 'EUR'
                        [arg] 
                      when 6 #e.g 'USDEUR' -> ['USD', 'EUR']
                        arg.scan(/.{3}/) 
                      else
                        raise ArgumentError.new("Wrong currency argument")
                      end
                    else
                      if currency.select{|it| it.length == 3}.length == currency.length
                        currency
                      else
                        raise ArgumentError.new("Wrong currency argument")
                      end
                    end
    end
    
    def <=>(other)
      if other.class != self.class
        raise ArgumentError.new("#{self.class.to_s} can't be compared with #{other.class.to_s}")
      end
      self.days <=> other.days
    end

    def after(time = Time.current)
      days = @days
      while days > 0 || !time.workday?(@currency)
        days -= 1 if time.workday?(@currency)
        time = time + 1.day
      end
      time
    end

    alias_method :from_now, :after
    alias_method :since, :after

    def before(time = Time.current)
      days = @days
      while days > 0 || !time.workday?(@currency)
        days -= 1 if time.workday?(@currency)
        time = time - 1.day
      end
      time
    end

    alias_method :ago, :before
    alias_method :until, :before
  end
end
