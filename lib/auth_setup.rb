class AuthSetup
  def self.call(env)
    new(env).configure!
  end
  
  def initialize(env)
    @env = env
    @account = Account.find_by_env(env)
    configure! if @account
  end
  
  def configure!
    strategy = @env['omniauth.strategy']
    strategy.options.secret = @account.secret
    strategy.options.auth_url = @account.login_url || '/login'
  end
end