class Account
  include MongoMapper::Document

  key :name, String, required: true
  key :subdomain, String, required: true
  key :host, String
  key :email, String, required: true
  key :support_email, String
  key :staff_domain, String
  key :login_url, String
  token :secret, size: 20
  timestamps!
  
  validates_uniqueness_of :subdomain, :host, :email, allow_blank: true
  validates_format_of :subdomain, with: /\A[a-z][a-z0-9]+$\z/
  validates_format_of :host, with: /\A(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\-]*[A-Za-z0-9])$\z/, allow_blank: true
  
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
  
  def staff_email?(email)
    email.split("@").last == staff_domain
  end
  
  def preferred_host
    host?? host : "#{subdomain}.#{ENV['APP_HOST']}"
  end
end
