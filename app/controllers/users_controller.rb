class UsersController < ApplicationController

  get '/dashboard/:user' do
    redirect("/login") if !logged_in?(session)
    @user = User.find_by(username: params[:user])
    haml :'users/dashboard'
  end
  
  get '/logout' do
    session.clear
    haml :index
  end
  
end