require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  helpers do
    def user_logged_in?
      !!session[:user_id]
    end

    def redirect_to_main_page
      if !user_logged_in?
        redirect '/users'
      end
    end

    def current_user
      if user_logged_in?
        User.find(session[:user_id])
      else
        redirect_to_main_page
      end
    end

  end

end
