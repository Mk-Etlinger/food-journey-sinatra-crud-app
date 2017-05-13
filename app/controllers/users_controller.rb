class UsersController < ApplicationController

  get '/dashboard/:user' do
    @user = User.find_by(username: params[:user])

    haml :'users/dashboard'
  end
  

end