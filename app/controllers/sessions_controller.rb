class SessionsController < ApplicationController
  def create
    user = User.from_jwt(auth_hash.extra.raw_info, current_account)
    reset_session
    session[:user_id] = user.id.to_s
    redirect_to session['omniauth.origin'] || '/'
  end
  
  def demo
    account = Account.find_by_subdomain('demo')
    payload = JWT.encode({
      id: params[:name].gsub(" ","").underscore,
      name: params[:name],
      email: "demo#{SecureRandom.hex(10)}@example.com",
      staff: false,
      admin: false
    }, account.secret)
    redirect_to "http://demo.#{ENV['APP_HOST']}/auth/jwt/callback?jwt=#{payload}"
  end

  def account
    session[:persona] = auth_hash.uid
    redirect_to accounts_path
  end

  def destroy
    reset_session
    redirect_to '/'
  end
  
  protected
  
  def auth_hash
    request.env['omniauth.auth']
  end
end
