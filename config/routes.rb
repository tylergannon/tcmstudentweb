
TcmStudentWeb::Application.routes.draw do

  resource :account
  resources :acu_point_infos
  resources :acu_point_categories
  resources :acu_point_therapeutic_functions
  resources :acu_points
  resources :articles
  resources :authors
  resources :categories
  resources :channels
  resources :citations
  resources :contraindications
  resources :formulas do
    collection do
      get :cards
      post :sort
    end
  end
  resources :herbs
  resources :patterns do
    collection do
      get :cards
    end
  end
  resources :pattern_symptoms do
    collection do
      post :sort
    end
  end
  resources :point_combinations
  resources :point_prescriptions
  resources :searches, :only=>[:index]
  resources :symptoms
  resources :tags
  resources :textbooks
  resources :therapeutic_functions
  resources :users
  resource :user_session

  match 'login' => 'user_sessions#new'
  match 'logout' => 'user_sessions#destroy'
  match 'signup' => 'users#new'
  match '/register/:activation_code' => 'activations#new', :as => :register
  match '/activate/:id' => 'activations#create', :as => :activate
  match '/' => 'formulas#index'

  match '/:controller/t/:tag_name' => '#index'

end

