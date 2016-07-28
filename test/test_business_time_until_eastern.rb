require File.expand_path('../helper', __FILE__)

describe "#business_time_until" do
  describe "on a TimeWithZone object in US Eastern" do
    before do
      ENV['TZ'] = 'Pacific Time (US & Canada)'
      Time.zone = 'Eastern Time (US & Canada)'
      BusinessTime::Config.load_currency_holidays(
        'USD' => [Date.civil(2014, 2, 17)],
        'GBP' => [Date.civil(2010, 4, 15)]
      )
    end

    it "should respect the time zone" do
       three_o_clock = Time.zone.parse("2014-02-17 15:00:00")
       four_o_clock = Time.zone.parse("2014-02-17 16:00:00")
       assert_equal 60*60, three_o_clock.business_time_until(four_o_clock)
    end

    it "should respect the time zone for TimeWithZone" do
      nine_o_clock = Time.zone.parse("2014-02-17 09:00:00")
      three_o_clock = Time.zone.parse("2014-02-17 15:00:00")
      four_o_clock = Time.zone.parse("2014-02-17 16:00:00")
      time = [  three_o_clock.business_time_until(four_o_clock),
                three_o_clock.business_time_until(four_o_clock, 'GBP'),
                three_o_clock.business_time_until(four_o_clock, 'GBPEUR'),
                three_o_clock.business_time_until(four_o_clock, 'GBP', 'EUR') ]
      time.each do |t|
        assert_equal 60*60, t
      end
      assert_equal nine_o_clock, Time.beginning_of_workday(three_o_clock)
    end

    it "should respect the time zone for Time" do
      three_o_clock = Time.parse("2014-02-17 15:00:00")
      nine_o_clock = Time.parse("2014-02-17 09:00:00")
      assert_equal nine_o_clock, Time.beginning_of_workday(three_o_clock)
    end

    it "should respect the time zone" do
      three_o_clock = Time.zone.parse("2014-02-17 15:00:00")
      four_o_clock = Time.zone.parse("2014-02-17 16:00:00")
      time = [  three_o_clock.business_time_until(four_o_clock, 'USD'),
                three_o_clock.business_time_until(four_o_clock, 'USDEUR'),
                three_o_clock.business_time_until(four_o_clock, 'USD', 'EUR') ]
      time.each do |t|
        assert_equal 0, t, t
      end
    end
  end
end
