require 'bundler'
Bundler.require

configure :development do
	set :database, {adapter: "sqlite3", database: "db/database.sqlite3"}
end
require_relative '../app/controllers/application_controller.rb'
# require_relative '../app/controllers/accounts_controller.rb'
# require_relative '../app/controllers/sessions_controller.rb'
# require_relative '../app/controllers/users_controller.rb'
require_all 'app/models'
