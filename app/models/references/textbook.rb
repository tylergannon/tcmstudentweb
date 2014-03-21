class References::Textbook < ActiveRecord::Base
  belongs_to :author, class_name: 'References::Author'
  has_many :citations, inverse_of: 'source'
end
