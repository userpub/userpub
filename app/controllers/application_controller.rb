class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  
  protected
  
  def current_account
    @current_account ||= Account.find_by_env(request.env)
  end
  
  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end
  
  def logged_in?
    !!current_user
  end
  
  def account_required
    render text: "Not Found", status: 404 unless current_account
  end
  
  def staff_required
    render text: "Must be staff to do that.", status: 401 unless current_user.try(:staff?)
  end
  
  helper_method :current_account, :current_user, :logged_in?
end