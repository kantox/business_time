require File.expand_path('../helper', __FILE__)

describe "date extensions" do
  
  before do
    BusinessTime::Config.currency_holidays = {
      'USD' => ['2010-04-14'],
      'GBP' => ['2010-04-15']
    }
  end
  
  it "know a weekend day is not a workday"  do
    assert(Date.parse("April 9, 2010").workday?)
    assert(!Date.parse("April 10, 2010").workday?)
    assert(!Date.parse("April 11, 2010").workday?)
    assert(Date.parse("April 12, 2010").workday?)
  end

  it "know a weekend day is not a workday (with a configured work week)"  do
    BusinessTime::Config.work_week = %w[sun mon tue wed thu]
    assert(Date.parse("April 8, 2010").weekday?)
    assert(!Date.parse("April 9, 2010").weekday?)
    assert(!Date.parse("April 10, 2010").weekday?)
    assert(Date.parse("April 12, 2010").weekday?)
  end

  it "know a holiday is not a workday" do
    july_4 = Date.parse("July 4, 2010")
    july_5 = Date.parse("July 5, 2010")

    assert(!july_4.workday?)
    assert(july_5.workday?)

    BusinessTime::Config.holidays << july_4
    BusinessTime::Config.holidays << july_5

    assert(!july_4.workday?)
    assert(!july_5.workday?)
  end
  
  it "currency holidays" do
    july_5 = Date.parse("July 5, 2010")

    assert(july_5.workday?('USD'))
    
    BusinessTime::Config.currency_holidays = {'USD' => ['2010-07-05']}
    assert(!july_5.workday?('USD'))
    assert(july_5.workday?('EUR'))
  end
  
  it "currency workdays" do
    assert(Date.parse("April 9, 2010").workday?('USD'))
    assert(Date.parse("April 9, 2010").workday?('USDEUR'))
    assert(Date.parse("April 9, 2010").workday?('USD', 'EUR'))
    assert(!Date.parse("April 14, 2010").workday?('USD'))
    assert(!Date.parse("April 14, 2010").workday?('USDEUR'))
    assert(!Date.parse("April 14, 2010").workday?('USD', 'EUR'))
  end
  
end
