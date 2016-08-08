require File.expand_path('../helper', __FILE__)

describe "business days" do

  before do
    BusinessTime::Config.load_currency_holidays(
      'USD' => [Date.civil(2010, 04, 14)],
      'GBP' => [Date.civil(2010, 04, 15)]
    )
  end

  describe "with a standard Date object" do

    it "move to day after tomorrow if we add a business day USD" do
      first = Date.parse("April 13th, 2010")
      later = [ 1.business_day('USD').after(first),
                1.business_day('USDEUR').after(first),
                1.business_day('USD', 'EUR').after(first) ]
      expected = Date.parse("April 15th, 2010")
      later.each do |l|
        assert_equal expected, l
      end
    end

    it "move to April 16 when USD/GBP" do
      first = Date.parse("April 13th, 2010")
      later = [ 1.business_day('USDGBP').after(first),
                1.business_day('GBPUSD').after(first),
                1.business_day('USD', 'GBP').after(first),
                1.business_day('USD', 'GBP', 'PLN').after(first) ]
      expected = Date.parse("April 16th, 2010")
      later.each do |l|
        assert_equal expected, l
      end
    end

  end
end
