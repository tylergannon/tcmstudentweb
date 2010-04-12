
TcmStudentWeb::Application.routes.draw do
  resources :authors
  resources :textbooks
  resources :articles
  resources :patterns
  resources :acu_points
  resources :formulas
  resources :tongue_qualities
  resources :therapeutic_functions
  resources :symptoms
  resources :pulse_qualities
  resources :contraindications
  resources :formula_categories
  resources :formula_comparisons
  resources :herbs
  resources :herb_categories
  resources :channels
  resources :formula_dui_yaos
  resources :patterns
  resources :point_prescriptions
  resources :point_prescription_acu_points
  resources :flavors
  resources :textbooks
  resource :user_session
  resource :account
  resources :users
  resources :searches
  match 'treatment_principles' => 'therapeutic_functions#index'
  match 'login' => 'user_sessions#new'
  match 'logout' => 'user_sessions#destroy'
  match 'signup' => 'users#new'
  match '/register/:activation_code' => 'activations#new', :as => :register
  match '/activate/:id' => 'activations#create', :as => :activate
  match '/' => 'formulas#index'
  match ':controller/category/:category_id' => '#categoryindex'
  match '/:controller(/:action(/:id))'
end
