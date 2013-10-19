Userpub::Application.routes.draw do
  constraints LanderConstraint.new do
    root to: 'lander#show', id: 'home'
  end
  
  constraints LanderConstraint.new(false) do
    
  end
end
