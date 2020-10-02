require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  helpers do
    def user_logged_in? #Determines if user is logged in by checking to see if session has an existing :user_id.
      !!session[:user_id]
    end

    def redirect_to_main_page #Redirects to welcome/home page if user is not logged in.
      if !user_logged_in?
        redirect '/users'
      end
    end

    def current_user #Finds current user assuming user is logged in (has an existing session. Otherwise, redirects to welcome/home page.
      if user_logged_in?
        User.find(session[:user_id])
      else
        redirect_to_main_page
      end
    end

  end

end
