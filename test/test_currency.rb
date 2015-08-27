require File.expand_path('../helper', __FILE__)

describe "currency" do
  
  let(:valid) {
    {
      'EUR' => ['EUR'],
      'EURUSD' => ['EUR', 'USD'],
      'USDEUR' => ['EUR', 'USD'],
      
      ['EUR'] => ['EUR'],
      ['EURUSD'] => ['EUR', 'USD'],
      ['USDEUR'] => ['EUR', 'USD'],
      ['USD', 'EUR'] => ['EUR', 'USD'],
      ['EUR', 'USD'] => ['EUR', 'USD'],
      ['USD', nil] => ['USD'],
      [nil, 'EUR'] => ['EUR'],
    }
  }
  
  let(:invalid) {
    [
      'EU', 'EURUS', ['US'], ['USDE'], ['USD', 'EU'], ['EURO'], 'EURO'
    ]
  }
  
  describe 'args' do
    it "correctly processes arguments" do
      valid.each do |k,v|
        assert_equal Currency.args(k).sort, v.sort
        assert_equal Currency.args(*k).sort, v.sort
      end
      assert_equal Currency.args(nil), nil
      assert_equal Currency.args([nil]), nil
    end
    
    it "Raises argument error" do
      invalid.each do |i|
        assert_raises ArgumentError do
          Currency.args(i)
          Currency.args(*i)
        end
      end
    end
    
  end
end
