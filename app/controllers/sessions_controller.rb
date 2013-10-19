class SessionsController < ApplicationController
  def create
    user = User.from_jwt(auth_hash.extra.raw_info)
    reset_session
    session[:user_id] = user.id.to_s
    redirect_to session['omniauth.origin'] || '/'
  end
  
  protected
  
  def auth_hash
    request.env['omniauth.auth']
  end
end
