Rails.application.routes.draw do  

  namespace :acupuncture do
    resources :points
  end

  namespace :acupuncture do
    resources :channels
  end

  namespace :diagnosis do
    resources :patterns
  end

  namespace :references do
    resources :textbooks
    resources :authors
    resources :citations
  end
  
  root 'diagnosis/patterns#index'
end
