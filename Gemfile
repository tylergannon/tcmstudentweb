# Edit this Gemfile to bundle your application's dependencies.
# This preamble is the current preamble for Rails 3 apps; edit as needed.
#path "/usr/bin/rails", :glob => "{*/,}*.gemspec"
#git "git://github.com/rails/rack.git"
gem "rails", "3.0.0.beta"

source 'http://gems.github.com'
source 'http://rubygems.org'
#gem 'repeated_auto_complete', :git => "git://github.com/patshaughnessy/auto_complete.git"
gem "authlogic", :git => "git://github.com/binarylogic/authlogic.git"
gem 'cancan', :git => "git://github.com/ryanb/cancan.git"
gem 'RedCloth'
gem "haml"

group :development do
#  gem "sqlite3-ruby", :require => "sqlite3"
  gem 'nifty-generators', :git =>  'git://github.com/dvyjones/nifty-generators.git', :branch => 'rails3'
end

group :test do
#  gem "sqlite3-ruby", :require => "sqlite3"
  gem "mocha", :git => "git://github.com/floehopper/mocha.git"
  gem "factory_girl", :git => "git://github.com/thoughtbot/factory_girl.git", :branch => "rails3"
  gem "shoulda", :git => "git://github.com/bmaddy/shoulda.git", :branch => "rails3"
end
