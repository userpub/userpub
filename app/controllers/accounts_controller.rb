class AccountsController < ApplicationController
  def show
    raise ActionController::RoutingError unless current_account
  end
end
