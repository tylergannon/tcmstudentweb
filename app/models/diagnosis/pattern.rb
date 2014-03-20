class Diagnosis::Pattern < ActiveRecord::Base
  belongs_to :citation, class_name: 'References::Citation'
end
