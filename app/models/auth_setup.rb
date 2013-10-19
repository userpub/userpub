class AuthSetup
  def self.call(env)
    new(env).configure!
  end
  
  def initialize(env)
    account = Account.find_by_env(env)
    return unless account
    
    strategy = env['omniauth.strategy']
    strategy.options.secret = account.secret
    strategy.options.auth_url = account.login_url || '/login'
  end
end