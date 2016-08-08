require File.expand_path('../helper', __FILE__)

describe "holidays" do
  before do
    BusinessTime::Config.load_currency_holidays(
      "KX™" => [Date.civil(2015, 1, 7)],
      "LP™" => [Date.civil(2015, 1, 8)]
    )
    BusinessTime::Config.load_holidays([Date.strptime('2015-01-05', "%F")])
    BusinessTime::Config.core_currencies = ["KX™", "LP™"]
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
