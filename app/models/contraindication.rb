class Contraindication < ActiveRecord::Base
  search_on :name
  autocomplete_format do  |ci|
    {:value=>ci.name}
  end
end

