require File.expand_path('../helper', __FILE__)

describe "business days with currencies" do
  before do
    BusinessTime::Config.currency_holidays = {
      'EUR' => ['2015-01-12', '2015-05-01']
    }
  end

  describe "with a standard Time object" do
    it "should move to monday if we add a business day to April, 30" do
      first = Time.parse("April 30th, 2015, 11:00 am")
      later = 1.business_day('EUR').after(first)
      expected = Time.parse("May 4th, 2015, 11:00 am")
      assert_equal expected, later
    end
  end
end
