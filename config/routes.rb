Userpub::Application.routes.draw do
  constraints host: ENV['APP_HOST'] do
    get '*path', to: redirect("http://www.#{ENV['APP_HOST']}/%{path}")
  end
  
  constraints LanderConstraint.new do
    root to: 'lander#show', id: 'home'
    get '/:id', to: 'lander#show'
    post '/demo', to: 'sessions#demo'
  end
  
  constraints AccountConstraint.new do
    get '/auth/jwt/callback', to: 'sessions#create'
    get '*path', to: 'accounts#show'
    root to: 'accounts#show', as: 'account_root'
  end
end
