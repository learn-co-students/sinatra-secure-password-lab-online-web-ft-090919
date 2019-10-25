require './app/controllers/application_controller'

require_all './app/controllers/'
# use Rack::MethodOverride

run ApplicationController
use UsersController
use SessionsController
use AccountsController
