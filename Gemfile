source "https://rubygems.org"


ruby "3.0.6"
gem "rails", "~> 7.1.0"
gem 'bcrypt'
gem 'faker'
gem 'bootstrap-sass'
gem "sprockets-rails"
gem "sqlite3", "~> 1.4"
gem "sassc-rails"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem 'will_paginate', '~> 3.3'
gem 'bootstrap-will_paginate', '1.0.0'
gem 'rails-i18n'
gem "tzinfo-data", platforms: %i[ mswin mswin64 mingw x64_mingw jruby ]


gem "bootsnap", require: false
group :development, :test do
  gem "debug", platforms: %i[ mri mswin mswin64 mingw x64_mingw ]
end


group :development do
  gem "web-console"
end


group :test do
  gem "capybara"
  gem "selenium-webdriver"
end

# Windows環境では、このgemを含める必要があります。（mac環境でもこのままで問題ありません）
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]