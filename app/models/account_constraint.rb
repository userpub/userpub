class AccountConstraint
  def initialize(inverse = false)
    @inverse = inverse
  end
  
  def matches?(request)
    return false if request.subdomain == 'www'
    match = !!Account.from_env(request.env)
    match = !match if @inverse
    match
  end
end