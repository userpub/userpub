class AccountsController < ApplicationController
  def show
  end
  
  def missing
    render status: 404
  end
end
