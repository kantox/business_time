require File.expand_path('../helper', __FILE__)

describe "business days" do
  describe "with a TimeWithZone object set to UTC" do
    before {
      Time.zone = 'UTC'
      BusinessTime::Config.load_currency_holidays(
        'USD' => [Date.civil(2010, 04, 14)],
        'GBP' => [Date.civil(2010, 04, 12)],
        'EUR' => [Date.civil(2010, 04, 15)]
      )
    }

    it "move to day after tomorrow if we add a business day" do
      first = Time.zone.parse("April 13th, 2010, 11:00 am")
      later = [ 1.business_day('USD').after(first),
                1.business_day('USDPLN').after(first),
                1.business_day('USD', 'PLN').after(first) ]

      expected = Time.zone.parse("April 15th, 2010, 11:00 am")
      later.each do |l|
        assert_equal expected, l
      end
    end

    it "move to April 9 is we subtract a business day" do
      first = Time.zone.parse("April 13th, 2010, 11:00 am")
      before = [  1.business_day('GBP').before(first),
                  1.business_day('GBP', 'PLN').before(first),
                  1.business_day('GBPPLN').before(first) ]
      expected = Time.zone.parse("April 9th, 2010, 11:00 am")
      before.each do |b|
        assert_equal expected, b
      end
    end

    it "move to April 16 after tomorrow if we add a business day" do
      first = Time.zone.parse("April 13th, 2010, 11:00 am")
      later = [ 1.business_day('USD', 'EUR', 'PLN').after(first),
                1.business_day('USDEUR').after(first),
                1.business_day('USD', 'EUR').after(first),
                1.business_day('USD', 'EUR', 'PLN').after(first) ]

      expected = Time.zone.parse("April 16th, 2010, 11:00 am")
      later.each do |l|
        assert_equal expected, l
      end
    end

  end
end
