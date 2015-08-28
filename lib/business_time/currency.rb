module BusinessTime::Currency
  # @return [Array] the list of currencies
  # @param [String+]
  def args(*currency)
    return nil if currency.length.zero?
    
    curr = if currency.length == 1 # string
              if currency.first.length.remainder(3).zero? # 'EURUSD'
                currency.first.scan /.{3}/
              elsif currency.first.length == 7           # 'EUR|USD'
                currency.first.split '|'
              else
                [''] # will raise an error below, DRY
              end
           else
             currency
           end

    raise ArgumentError.new("Wrong currency argument [#{currency}]") \
      unless curr.all? { |it| String === it && it.length == 3 }

    curr.uniq
  end
end