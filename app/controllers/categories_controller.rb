class CategoriesController < ApplicationController
  respond_to :html, :js
  inherit_resources
  json_search
end

