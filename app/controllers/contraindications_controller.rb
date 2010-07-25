class ContraindicationsController < ApplicationController
  respond_to :html, :js
  inherit_resources :only => :index
  json_search
end

