class SessionsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    h = auth["extra"]["raw_info"]
    u = User.find_or_initialize_by(id: h['id'])
    u.login = h['login']
    u.email = h['email']
    u.avatar_url = h['avatar_url']
    u.name =  h['name']
    u.save!
    session[:user_id] = u.id
    redirect_to :back
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

end