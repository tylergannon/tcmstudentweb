Rails.application.routes.draw do  

  namespace :treatment do
    resources :point_prescriptions
  end

  namespace :acupuncture do
    resources :points
    resources :channels
  end

  namespace :diagnosis do
    resources :patterns
    resources :symptoms
    resources :pattern_symptoms
  end

  namespace :references do
    resources :textbooks
    resources :authors
    resources :citations
  end
  
  root 'diagnosis/patterns#index'
end
