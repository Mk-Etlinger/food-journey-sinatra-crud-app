require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "food_journey"
  end

  get '/' do

    haml :index
  end

  get '/signup' do
    # redirect("/dashboard") if logged_in?(session)

    haml :'registration/signup'
  end
  
  post '/signup' do
    @user = User.new(params)
    if @user.save
      session[:id] = @user.id
      redirect "/dashboard/#{@user.username}"
    else
      redirect "/signup"
    end
    
  end
  
  get '/login' do
    redirect("/tweets") if logged_in?(session)
    haml :login
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
    else
      redirect "/login"
    end
    redirect "/tweets"
  end

  get '/logout' do
    session.clear
    redirect "/login"
  end

  helpers do
    def logged_in?(session)
      !!session[:id]
    end
    
    def current_user(session)
        User.find(session[:id]) if session[:id]
    end
    
  end

  


end