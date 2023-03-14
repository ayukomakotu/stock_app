source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'rails', '7.0.4.3'
gem 'bootstrap-sass'
gem 'active_storage_validations'
gem 'image_processing'
gem 'mini_magick'
gem 'bcrypt'
gem 'faker'
gem 'will_paginate'
gem 'bootstrap-will_paginate'
gem 'puma'
gem 'sass-rails'
# gem 'webpacker'
gem 'sprockets-rails'
gem 'cssbundling-rails'
gem 'importmap-rails'
gem 'stimulus-rails'
# gem 'turbolinks'
gem 'turbo-rails'
gem 'jbuilder'
gem 'bootsnap', require: false
gem 'rexml'
gem 'rss'
gem 'devise'
gem 'dotenv-rails'
# rspecが不安定でたまにログインできずに落ちるバグを解消するのにAccess-Control-Allow-Origin.の設定が必要だったため追加
gem 'rack-cors'

group :development, :test do
  # gem 'sqlite3'
  gem 'pg'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  # gem 'faker'
end

group :development do
  gem 'web-console'
  #gem 'rack-mini-profiler'
  gem 'listen'
  gem 'spring'
  #gem 'spring-watcher-listen'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'launchy'
end

group :production do
  gem 'pg'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'rails-i18n'
