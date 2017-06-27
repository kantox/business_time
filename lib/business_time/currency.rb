module BusinessTime
  module Currency

    # @return [Array] the list of currencies
    # @param [String+]
    def args(*currency)
      return Set.new if currency.empty?

      curr = if currency.length == 1 # string
               Set.new(currency.first.scan(/\w{,3}/).reject(&:empty?))
             else
               currency.to_set
             end

      raise ArgumentError.new("Wrong currency argument [#{currency}]") \
        unless !curr.empty? && curr.all? { |it| String === it && it.length == 3 }

      curr.merge(BusinessTime::Config.core_currencies)
    end
  end
end
