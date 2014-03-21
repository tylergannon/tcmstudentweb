Rails.application.routes.draw do  

  namespace :clinic do
    resources :patients do
      resources :visits, only: :index
    end
    resources :visits
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

  namespace :treatment do
    resources :point_prescription_points
    resources :point_prescriptions
  end

  devise_for :practitioners, class_name: "Clinic::Practitioner"
  root 'diagnosis/patterns#index'
end
