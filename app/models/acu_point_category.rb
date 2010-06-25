class AcuPointCategory < ActiveRecord::Base
  belongs_to :acu_point
  belongs_to :category

  def name
    category_name
  end

  def category_name
    category.name if category
  end

  def category_name=(name)
    return if name.blank?
    self.category = Category.where("lower(name) = '#{name.downcase}'")[0]
    unless self.category
      self.category = Category.create(:name => name)
    end
  end
end

