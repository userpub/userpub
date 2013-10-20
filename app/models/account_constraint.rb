class AccountConstraint
  def initialize(inverse = false)
    @inverse = inverse
  end
  
  def matches?(request)
    match = !!Account.find_by_env(request.env)
    match = !match if @inverse
    match
  end
end