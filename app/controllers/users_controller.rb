class UsersController < ApplicationController

  get '/dashboard/:user' do
    authenticate_user
    
    if current_user.username == params[:user]
      haml :'users/dashboard'
    else
      redirect_to_dashboard
    end
  end
  
  get '/logout' do
    session.clear
    haml :index
  end
  
end