Userpub::Application.routes.draw do
  constraints LanderConstraint.new do
    root to: 'lander#show', id: 'home'
  end
  
  constraints LanderConstraint.new(false) do
    get '/auth/jwt/callback', to: 'sessions#create'
    get '*', to: 'accounts#show'
  end
end
