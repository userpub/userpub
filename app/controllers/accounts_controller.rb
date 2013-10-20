class AccountsController < ApplicationController
  respond_to :html
  
  before_filter :persona_required, only: [:index, :create, :destroy, :edit, :update]
  before_filter :find_account, only: [:update, :destroy, :edit, :new_token, :create_token]
  layout 'manage', except: [:show]
  
  def show
    redirect_to accounts_path unless current_account
  end
  
  def index
    @accounts = Account.where(email: persona)
    respond_with @accounts
  end
  
  def create
    @account = Account.new({email: persona}.merge(params[:account]))
    flash[:notice] = "Successfully created account!" if @account.save
    respond_with @account
  end
  
  def new_token
    render action: :token
  end
  
  def create_token
    @payload = JWT.encode(params[:token].reject{|k,v| v.blank?}, @account.secret)
    render action: :token
  end

  def destroy
    @account.destroy
    redirect_to accounts_path
  end
  
  def edit
  end
  
  def new
    @account = Account.new(params[:account])
  end
  
  def update
    flash[:notice] = "Updated account successfully." if @account.update_attributes(params[:account])
    respond_with @account
  end
  
  def missing
    render text: 'Not Found', status: 404
  end
  
  protected
  
  def find_account
    @account = Account.where(email: persona).find(params[:id])
  end
end
