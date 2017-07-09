require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base 

  configure do
    enable :sessions
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "food_journey"
    use Rack::Flash, :sweep => true
  end

  get '/' do
    haml :index
  end

  helpers do
    def logged_in?
      !!session[:id]
    end
    
    def current_user
      @user ||= User.find_by(id: session[:id])
    end

    def authenticate_user
      redirect("/login") if !logged_in?
    end

    def redirect_to_dashboard
      redirect "/dashboard/#{current_user.username}"
    end
  end

end


