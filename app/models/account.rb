class Account
  include MongoMapper::Document

  key :name, String, required: true
  key :subdomain, String, required: true
  key :host, String
  key :email, String, required: true
  key :login_url, String
  token :secret, size: 20
  timestamps!
  
  validates_uniqueness_of :subdomain, :host, :email
  
  many :users
  
  def self.find_by_env(env)
    return find_by_subdomain(ENV['DEBUG_SUBDOMAIN']) if ENV['DEBUG_SUBDOMAIN'] && ENV['RACK_ENV'] == 'development'
      
    request = Rack::Request.new(env)
    
    host = request.host
    Rails.logger.debug "Account: looking up account for #{request.host}"
    subdomain = host.split('.').first if host.include?(ENV['APP_HOST'])
    Account.find_by_subdomain(subdomain) || Account.find_by_host(request.host)
  end
  
  def make_token(claims)
    JWT.encode(claims, secret)
  end
end
