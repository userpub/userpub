class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  
  protected
  
  def current_account
    Account.find_by_env(request.env)
  end
  
  helper_method :current_account
end
