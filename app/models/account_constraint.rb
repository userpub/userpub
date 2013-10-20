class AccountConstraint
  def initialize(inverse = false)
    @inverse = inverse
  end
  
  def matches?(request)
    match = !!Account.from_env(request.env)
    match = !match if @inverse
    match
  end
end