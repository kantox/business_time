require File.expand_path('../helper', __FILE__)

describe "fixnum extensions" do
  before do
    BusinessTime::Config.load_currency_holidays(
      'EUR' => [Date.civil(2015, 01, 12), Date.civil(2015, 05, 01)],
      'USD' => [Date.civil(2015, 05, 04)],
      'GBP' => [Date.civil(2015, 05, 05)]
    )
  end

  it "respond to business_hours by returning an instance of BusinessHours" do
    assert(1.respond_to?(:business_hour))
    assert(1.respond_to?(:business_hours))
    assert 1.business_hour.instance_of?(BusinessTime::BusinessHours)
  end

  it "respond to business_days by returning an instance of BusinessDays" do
    assert(1.respond_to?(:business_day))
    assert(1.respond_to?(:business_days))
    assert 1.business_day.instance_of?(BusinessTime::BusinessDays)
    assert 1.business_day('EUR').instance_of?(BusinessTime::BusinessDays)
    assert 1.business_day('EUR', 'USD').instance_of?(BusinessTime::BusinessDays)
  end
end
