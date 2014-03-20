Rails.application.routes.draw do  
  namespace :references do
    resources :textbooks
    resources :authors
    resources :citations
  end

  resources :patterns
  
  root 'patterns#index'
end
