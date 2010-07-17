class AcuPointCategory < ActiveRecord::Base
  belongs_to :acu_point
  belongs_to :category
  validates_each :channels do |model, attr, value|
    model.errors.add(attr, 'collection can\'t be empty.') if value.size==0
  end
  validates_presence_of :acu_point, :category

  named_association :category, :name, :create => true
  anaf_habtm :channels

  scope :with_category_name, lambda{|name|
    cat = Category.named(name)
    id = cat.id if cat
    joins(:category).where(:categories=>{:id=>id})
  }
end

