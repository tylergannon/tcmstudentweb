module ActiveRecord
  class Base
    def self.acts_as_cited
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
    
    def self.named_association(member, klass, attribute, create=nil)
      member = member.to_s
      klass = klass.name
      attribute = attribute.to_s
      if create
        class_eval "def #{member}_#{attribute}=(#{attribute}); 
        return if #{attribute}.blank?
        self.#{member} = #{klass}.named(#{attribute})
        self.#{member} = self.#{member} ||= #{klass}.create(:#{attribute} => #{attribute})
        end;"
      else
        class_eval "def #{member}_#{attribute}=(#{attribute}); self.#{member} = #{klass}.named(#{attribute}) unless #{attribute}.blank?; end;"
      end
      class_eval "def #{member}_#{attribute}; #{member}.#{attribute} if #{member}; end;"
    end
    
    def self.search_on(*cols)
      class_eval "def self.search_columns; #{cols.map{|t| t.to_s}.to_ary.inspect}; end;"
      class_eval do
        scope :search, lambda{|str|
          items = like_condition(str.downcase)
          if scopes.has_key?(:search_mod)
            items = items.search_mod
          end
          items
        }
      end
    end
    
    def self.anaf_habtm(association, &block)
      class_eval do
        finder = proc {|id| association.to_s.singularize.camelize.constantize.where(:id=>id).first
        }
        set_coll = proc {|me, coll| me.send("#{association.to_s.tableize}=", coll)}
        define_method "#{association.to_s.tableize}_attributes=", lambda{|coll_params|
          coll = []
          coll_params.each_value do |params|
            next if params["_destroy"] == "1"
            obj = finder.call(params["id"]) if params.has_key?("id")
            coll << block.call(params, obj)
          end
          set_coll.call(self, coll)
        }
      end
    end

    def self.lookup(params)
      str = params[:id]
      if str.match(/\D/)
        named(str)
      else
        find(str)
      end
    end

    def self.like_condition(str)
      where(condition("ilike '%#{str}%'"))
    end

    def self.equals_condition(str)
      where(condition("= '#{str.downcase}'"))
    end
    
    def self.named(str)
      equals_condition(str.downcase)[0]
    end

    def self.search_columns
      []
    end

    def self.find_or_create(field, value)
      value = value.to_s.strip
      return if value.empty?
      a = find(:first, :conditions => "lower('#{value}') = lower(#{field.to_s})")
      a ||= create(field => value)
    end

    def link_name
      name
    end

    def link_title
      ""
    end

    def self.find_by_textbook(text)
      textbook_ids = Textbook.search(text).map{|v| v.id}
      find(:all, :joins => :citation, :conditions => "citations.textbook_id in (#{textbook_ids.join(", ")})")
      # Formula.find(:all, :joins => :citation, :conditions => {:citations => {:textbook_id => a.id }})

    end


    def self.condition(cond)
       search_columns.map{|c| "trim(lower(#{c})) #{cond}"}.join(" or ")
    end
  end
end

