ActionController::Routing::Routes.draw do |map|
  map.resources :patterns

  map.resources :acu_points
  map.resources :formulas
  map.resources :tongue_qualities
  map.resources :therapeutic_functions
  map.resources :symptoms
  map.resources :pulse_qualities
  map.resources :contraindications
  map.resources :formula_categories
  map.resources :herbs
  map.resources :herb_categories
  map.resources :channels
  map.resources :formula_dui_yaos
  map.resources :patterns
  map.resources :flavors

  map.resource :user_session
  # map.root :controller => "user_sessions", :action => "new" # optional, this just sets the root route
  map.resource :account, :controller => "users"
  map.resources :users

  map.connect 'treatment_principles', :controller => 'therapeutic_functions'
  
  map.connect 'login', :controller => 'user_sessions', :action => 'new'
  map.connect 'logout', :controller => 'user_sessions', :action => 'destroy'
  map.connect 'signup', :controller => 'users', :action => 'new'

  map.register '/register/:activation_code', :controller => 'activations', :action => 'new'
  map.activate '/activate/:id', :controller => 'activations', :action => 'create'

  map.root :controller => "formulas"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/category/:category_id', :action => 'categoryindex'
  map.connect ':controller/:action/:id'

  map.connect ':controller/:action/:id.:format'
end
