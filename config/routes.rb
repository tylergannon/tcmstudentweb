Rails.application.routes.draw do  
  resources :patterns
  
  root 'patterns#index'
end
