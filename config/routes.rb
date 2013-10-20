Userpub::Application.routes.draw do
  constraints LanderConstraint.new do
    root to: 'lander#show', id: 'home'
  end
  
  constraints AccountConstraint.new do
    get '/auth/jwt/callback', to: 'sessions#create'
    get '*path', to: 'accounts#show'
    root to: 'accounts#show', as: 'account_root'
  end
  
  constraints AccountConstraint.new(true) do
    get '*path', to: 'accounts#missing'
  end
end
