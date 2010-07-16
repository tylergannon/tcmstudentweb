module TcmStudentWeb
  module ActiveRecordExtensions
    def simple_association_text(association, delim=',')
      class_eval "    def #{association.to_s.tableize}_text=(text)
              delim = '#{delim}'
              items = text.split(delim).strip_each.reject{|t|t.empty?}
              association = items.map{|t| #{association.to_s.singularize.camelize}.named(t)}.reject{|t|t.empty?}
            end
        "
    end

    def acts_as_cited
      class_eval do
        belongs_to :citation, :dependent => :destroy
        accepts_nested_attributes_for :citation, :allow_destroy => true, :reject_if => proc {|a| a['textbook_title'].blank?}
        scope :bensky, lambda {joins(:citation).where("citations.textbook_id = 2")}
        scope :gio, lambda {joins(:citation).where("citations.textbook_id = 20")}

        scope :order_by_text, joins(:citation).order('citations.textbook_id')

        scope :from_text, lambda { |name|
          tb = Textbook.where("textbooks.abbrev = '#{name}'")
          joins(:citation).where("citations.textbook_id = #{tb[0].id}") unless tb.size==0
        }
      end
    end
  end
end

