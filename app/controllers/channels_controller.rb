class ChannelsController < ApplicationController
  respond_to :html, :js
  inherit_resources
  json_search
  eager_loading_resource

end

