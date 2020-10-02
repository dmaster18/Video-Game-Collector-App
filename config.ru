require './config/environment'


use Rack::MethodOverride
use ConsolesController
use GamesController
use UsersController
run ApplicationController
