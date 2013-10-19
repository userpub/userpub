class SessionsController < ApplicationController
  def create
    render json: auth_hash
  end
  
  protected
  
  def auth_hash
    request.env['omniauth.auth']
  end
end
