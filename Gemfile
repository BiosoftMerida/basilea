source 'http://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.8'
gem 'bootstrap-sass', '3.3.0.0'
gem 'font-awesome-rails', '4.3.0.0'

# Use sqlite3 as the database for Active Record
gem 'pg'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Use Angular-rails for .js.coffee-angular assets and views
gem 'angularjs-rails', '~> 1.4', '>= 1.4.7'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

#HAML Porque HTML SUCKS!
gem 'haml'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# devise for authentication
gem 'devise'
# Seguridad añadida a devise
gem 'devise_security_extension'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

gem "minitest-rails"
gem 'mocha'
group :test do
  gem "minitest-rails-capybara"
  gem 'capybara-screenshot'
  gem 'selenium-webdriver'
end


group :development do
  gem 'better_errors'

  gem 'binding_of_caller'

  #revisar en çonfig/environments/development.rb
  #correo en http://127.0.0.1:1080
  gem 'mailcatcher'

  gem 'annotate'

  gem 'html2haml'

  # Generacion de las vistas en formato haml
  gem 'haml-rails'
  #generador de scaffold con structura de bootstrap
  gem 'bootstrap-generators', git: 'git://github.com/decioferreira/bootstrap-generators.git'

end

#Carga de Imagenes
gem 'carrierwave'


# Carga de documentos paginados
gem 'jquery-fileupload-rails'
gem 'remotipart', '~> 1.2'


gem 'rmagick', '~> 2.13.4'

gem 'cancancan', '~> 1.10'

#gem ' cocoon'

#DATETIME PICKER
gem 'momentjs-rails', '>= 2.9.0'
gem 'bootstrap3-datetimepicker-rails', '~> 4.14.30'

gem 'dentaku'

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw]

gem 'descriptive_statistics', '~> 2.4.0',  :require => 'descriptive_statistics/safe'

#Dar formato a un archivo excel
gem 'spreadsheet'
gem 'roo'

gem 'rgeo'

gem 'activerecord-postgis-adapter'

gem 'rename'

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw]

#heroku
gem 'rails_12factor', group: :production

gem 'unicorn'