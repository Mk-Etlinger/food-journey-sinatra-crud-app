class UsersController < ApplicationController
  get '/dashboard/:user' do
    authenticate_user

    if current_user.username == params[:user]
      haml :'users/dashboard'
    else
      redirect_to_dashboard
    end
  end

  get '/signup' do
    haml :'registration/signup'
  end

  post '/signup' do
    @user = User.new(params)

    if @user.save
      session[:id] = @user.id
      redirect_to_dashboard
    else
      flash[:error] = @user.errors.full_messages
      redirect '/signup'
    end
  end

  get '/login' do
    redirect_to_dashboard if logged_in?
    haml :login
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect_to_dashboard
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  get '/logout' do
    session.clear
    redirect '/'
    haml :index
  end
end
