require File.expand_path('../helper', __FILE__)

describe "#business_time_until" do
  describe "on a TimeWithZone object in US Eastern" do
    before do
      Time.zone = 'Eastern Time (US & Canada)'
      BusinessTime::Config.currency_holidays = {
        'USD' => ['2014-02-17'],
        'GBP' => ['2010-04-15']
      }
    end

    it "should respect the time zone" do
      three_o_clock = Time.zone.parse("2014-02-17 15:00:00")
      four_o_clock = Time.zone.parse("2014-02-17 16:00:00")
      time = [  three_o_clock.business_time_until(four_o_clock), 
                three_o_clock.business_time_until(four_o_clock, 'GBP'),
                three_o_clock.business_time_until(four_o_clock, 'GBPEUR'),
                three_o_clock.business_time_until(four_o_clock, 'GBP', 'EUR') ]
      time.each do |t|
        assert_equal 60*60, t
      end
    end
    
    it "should respect the time zone" do
      three_o_clock = Time.zone.parse("2014-02-17 15:00:00")
      four_o_clock = Time.zone.parse("2014-02-17 16:00:00")
      time = [  three_o_clock.business_time_until(four_o_clock, 'USD'),
                three_o_clock.business_time_until(four_o_clock, 'USDEUR'),
                three_o_clock.business_time_until(four_o_clock, 'USD', 'EUR') ]
      time.each do |t|
        assert_equal 0, t
      end
    end
    
  end
end
