require File.expand_path('../helper', __FILE__)

describe "currency" do
  include BusinessTime::Currency
  
  let(:valid) {
    {
      'EUR' => ['EUR'],
      'EURUSD' => ['EUR', 'USD'],
      'USDEUR' => ['EUR', 'USD'],
      'EUR|USD' => ['EUR', 'USD'],
      'USD|EUR' => ['EUR', 'USD'],
      
      ['EUR'] => ['EUR'],
      ['EURUSD'] => ['EUR', 'USD'],
      ['USDEUR'] => ['EUR', 'USD'],
      ['EUR|USD'] => ['EUR', 'USD'],
      ['USD|EUR'] => ['EUR', 'USD'],
      ['USD', 'EUR'] => ['EUR', 'USD'],
      ['EUR', 'USD'] => ['EUR', 'USD'],
      ['USD', 'EUR', 'PLN'] => ['EUR', 'USD', 'PLN'],
      ['PLN', 'EUR', 'USD'] => ['EUR', 'USD', 'PLN'],
    }
  }
  
  let(:invalid) {
    [
      'EU', 'EURUS', ['US'],
      ['USDE'], ['USD', 'EU'],
      ['EURO'], 'EURO',
      ['USD', nil],
      [nil, 'EUR'],
    ]
  }
  
  describe 'args' do
    it "correctly processes arguments" do
      valid.each do |k,v|
        assert_equal args(*k).sort, v.sort
      end
      assert_equal args(), []
    end
    
    it "Raises argument error" do
      invalid.each do |i|
        assert_raises ArgumentError do
          args(*i)
        end
      end
    end
    
  end
end
