class LanderConstraint
  def initialize(on = true)
    @on = on
  end
  
  def matches?(request)
    lander = (ENV['DEBUG_SUBDOMAIN'] || request.subdomain) == 'www'
    @on ? lander : !lander
  end
end