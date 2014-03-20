Rails.application.routes.draw do  

  namespace :acupuncture do
    resources :points
    resources :channels
  end

  namespace :diagnosis do
    resources :patterns
    resources :symptoms
  end

  namespace :references do
    resources :textbooks
    resources :authors
    resources :citations
  end
  
  root 'diagnosis/patterns#index'
end
