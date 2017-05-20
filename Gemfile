source 'http://rubygems.org'
ruby '2.3.4'

gem 'sinatra'
gem 'activerecord', :require => 'active_record'
gem 'sinatra-activerecord', :require => 'sinatra/activerecord'
gem 'rake'
gem 'require_all'
gem 'thin'
gem 'bcrypt'
gem 'haml'
gem 'rack-flash3'
gem 'guard'
gem 'pg', :group => :production
gem 'bundler', '~> 1.13', '>= 1.13.7'

group :development do
  gem 'guard-shotgun', :git => 'https://github.com/rchampourlier/guard-shotgun.git'
  gem 'sqlite3'
  gem 'tux'
  gem 'pry'
  gem 'shotgun'
end

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'rack-test'
  gem 'database_cleaner', git: 'https://github.com/bmabey/database_cleaner.git'
end