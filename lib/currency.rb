module Currency
  extend self
  
  def args(*currency)
    currency = currency.flatten.compact
    return if currency.blank?
    case currency.length
    when 0
      nil
    when 1
      arg = currency[0]
      return if arg.blank?
      case arg.length
      when 3 #e.g. 'EUR'
        [arg] 
      when 6 #e.g 'USDEUR' -> ['USD', 'EUR']
        arg.scan(/.{3}/).uniq
      else
        raise ArgumentError.new("Wrong currency argument")
      end
    else
      if currency.select{|it| it.length == 3}.length == currency.length
        currency.uniq
      else
        raise ArgumentError.new("Wrong currency argument")
      end
    end
  end
end