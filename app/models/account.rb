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
  
  def self.find_by_env(env)
    return find_by_subdomain(ENV['DEBUG_SUBDOMAIN']) if ENV['DEBUG_SUBDOMAIN'] && ENV['RACK_ENV'] == 'development'
      
    request = Rack::Request.new(env)
    
    host = request.host
    subdomain = host.split('.').first if host.include?(ENV['APP_HOST'])
    Account.where(:$or => [{subdomain: subdomain}, {host: host}]).first
  end
end
