Userpub::Application.routes.draw do
  constraints host: /^(#{ENV['APP_HOST']}|userpub.r13.railsrumble.com)$/i do
    get '/', to: redirect("http://www.#{ENV['APP_HOST']}/")
    get '*path', to: redirect("http://www.#{ENV['APP_HOST']}/%{path}")
  end

  constraints host: 'userpub.r12.railsrumble.com' do
    get '*path', to: redirect("http://www.#{ENV['APP_HOST']}/%{path}")
  end
  
  constraints LanderConstraint.new do
    root to: 'lander#show', id: 'home'
    get '/:id', to: 'lander#show'
    post '/demo', to: 'sessions#demo'
  end
  
  constraints AccountConstraint.new do
    get '/auth/jwt/callback', to: 'sessions#create'
    root to: 'accounts#show', as: 'account_root'
    get '/logout', to: 'sessions#destroy'
  end
end
