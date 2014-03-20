class References::Textbook < ActiveRecord::Base
  belongs_to :author, class_name: 'References::Author'
end
