require File.expand_path('../helper', __FILE__)

describe "holidays" do
  before do
    BusinessTime::Config.currency_holidays = {
      "KX™" => ['2015-01-07'],
      "LP™" => ['2015-01-08']
    }
    BusinessTime::Config.holidays = ['2015-01-05']
  end
  
  let(:params) {
    [['USD'], ['USD|EUR'], ['USDEUR'], ['USD', 'EUR'], ['USD', 'GBP', 'EUR']]
  }
  
  it "takes into account default holidays when no currency specified" do
    assert(!Time.parse("2015-01-05").workday?)
    assert( Time.parse("2015-01-06").workday?)
  end
  
  it "takes into account kantox holidays with any currency" do
    day = Time.parse("2015-01-07")
    params.each do |p|
      assert(!day.workday?(*p))
    end
    
    BusinessTime::Config.currency_holidays["KX™"] = []
    params.each do |p|
      assert( day.workday?(*p))
    end
  end
  
  it "takes into account lp holidays with any currency" do
    day = Time.parse("2015-01-08")
    params.each do |p|
      assert(!day.workday?(*p))
    end
    
    BusinessTime::Config.currency_holidays["LP™"] = []
    params.each do |p|
      assert( day.workday?(*p))
    end
  end
  
  it "works" do
    day = Time.parse("2015-01-09")
    params.each do |p|
      assert( day.workday?(*p))
    end
  end
  
end
