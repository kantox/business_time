# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "business_time/version"

Gem::Specification.new do |s|
  s.name = "business_time"
  s.version = BusinessTime::VERSION
  s.summary = %Q{Support for doing time math in business hours and days}
  s.description = %Q{Have you ever wanted to do things like "6.business_days.from_now" and have weekends and holidays taken into account?  Now you can.}
  s.homepage = "https://github.com/bokmann/business_time"
  s.authors = ["bokmann", 'Kantox LTD']
  s.email = ["dbock@codesherpas.com", 'aleksei.matiushkin@kantox.com']
  s.license = "MIT"

  s.files = `git ls-files -z`.split("\x0").reject { |f| f.match(/(test|spec|features)\//) }
  s.require_paths = %w(lib)

  s.add_dependency 'activesupport', '>= 3.1.0', '< 5'
  s.add_dependency 'tzinfo'

  s.add_development_dependency "rake", '~> 10'
  s.add_development_dependency "rdoc", '~> 4'
  s.add_development_dependency "minitest", '~> 5'
  s.add_development_dependency "minitest-rg", '~> 5'
  s.add_development_dependency "minitest-reporters", '~> 1'
end
