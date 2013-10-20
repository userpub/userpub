Userpub::Application.routes.draw do
  constraints host: ENV['APP_HOST'] do
    match '*path', to: redirect("http://www.#{ENV['APP_HOST']}/%{path}")
  end
  
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
