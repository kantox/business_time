require File.expand_path('../helper', __FILE__)

describe "calculating business duration" do

  before do
    BusinessTime::Config.load_currency_holidays(
      'USD' => [Date.civil(2010, 12, 21), Date.civil(2010, 12, 25), Date.civil(2012, 05, 29)]
    )
  end

  it "properly calculate business duration" do
    monday = Date.parse("December 20, 2010")
    wednesday = Date.parse("December 22, 2010")
    assert_equal 1, monday.business_days_until(wednesday, false, 'USD')
    assert_equal 1, monday.business_days_until(wednesday, false, 'USDEUR')
    assert_equal 1, monday.business_days_until(wednesday, false, 'USD', 'EUR')
  end

  it "properly calculate business time with respect to work_hours" do
    friday = Time.parse("December 24, 2010 15:00")
    monday = Time.parse("December 27, 2010 11:00")
    BusinessTime::Config.work_hours = {
        :mon => ["9:00", "17:00"],
        :fri => ["9:00", "17:00"],
        :sat => ["10:00", "15:00"]
    }
    assert_equal 4.hours, friday.business_time_until(monday, 'USD')
    assert_equal 4.hours, friday.business_time_until(monday, 'USDEUR')
    assert_equal 4.hours, friday.business_time_until(monday, 'USD', 'EUR')
  end

  it "properly calculate business time with respect to work_hours with UTC time zone" do
    Time.use_zone('UTC') do
      monday = Time.zone.parse("May 28 11:04:26 +0300 2012")
      tuesday = Time.zone.parse("May 29 17:56:45 +0300 2012")
      BusinessTime::Config.work_hours = {
          :mon => ["9:00", "18:00"],
          :tue => ["9:00", "18:00"],
          :wed => ["9:00", "18:00"]
      }
      assert_equal 32400.0, monday.business_time_until(tuesday, 'USD')
    end
  end
end

