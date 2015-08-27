require File.expand_path('../helper', __FILE__)

describe "calculating business dates" do
  
  before do
    BusinessTime::Config.currency_holidays = {
      'USD' => ['2010-12-27']
    }
  end
  
  it "properly calculate business dates over weekends plus USD Monday holiday" do
    friday = Date.parse("December 24, 2010")
    tuesday = Date.parse("December 28, 2010")
    assert_equal [friday], friday.business_dates_until(tuesday, 'USD')
    assert_equal [friday], friday.business_dates_until(tuesday, 'USDEUR')
    assert_equal [friday], friday.business_dates_until(tuesday, 'USD', 'EUR')
  end

end