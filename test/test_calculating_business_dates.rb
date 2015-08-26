require File.expand_path('../helper', __FILE__)

describe "calculating business dates" do
  
  before do
    BusinessTime::Config.currency_holidays = {
      'USD' => ['2010-12-27']
    }
  end
  
  it "properly calculate business dates over weekends" do
    friday = Date.parse("December 24, 2010")
    monday = Date.parse("December 27, 2010")
    assert_equal [friday], friday.business_dates_until(monday)
  end

  it "properly calculate business dates over weekends plus USD Monday holiday" do
    friday = Date.parse("December 24, 2010")
    tuesday = Date.parse("December 28, 2010")
    assert_equal [friday], friday.business_dates_until(tuesday, 'USD')
    assert_equal [friday], friday.business_dates_until(tuesday, 'USDEUR')
    # assert_equal [friday], friday.business_dates_until(tuesday, 'USD', 'EUR')
  end

  it "properly calculate business dates without weekends" do
    monday = Date.parse("December 20, 2010")
    tuesday = Date.parse("December 21, 2010")
    wednesday = Date.parse("December 22, 2010")
    assert_equal [monday, tuesday], monday.business_dates_until(wednesday)
  end

  it "properly calculate business dates with respect to holidays" do
    free_friday = Date.parse("December 17, 2010")
    wednesday = Date.parse("December 15,2010")
    thursday = Date.parse("December 16,2010")
    monday = Date.parse("December 20, 2010")
    BusinessTime::Config.holidays << free_friday
    assert_equal [wednesday, thursday], wednesday.business_dates_until(monday)
  end

  it "properly calculate business dates with respect to work_hours" do
    friday = Date.parse("December 24, 2010")
    saturday = Date.parse("December 25, 2010")
    monday = Date.parse("December 27, 2010")
    BusinessTime::Config.work_hours = {
        :fri => ["9:00", "17:00"],
        :sat => ["10:00", "15:00"]
    }
    assert_equal [friday, saturday], friday.business_dates_until(monday)
  end

end