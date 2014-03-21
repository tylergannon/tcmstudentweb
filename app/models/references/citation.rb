class References::Citation < ActiveRecord::Base
  belongs_to :source, polymorphic: true
end
