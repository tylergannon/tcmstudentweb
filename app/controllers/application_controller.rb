# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :authenticate_user!, :only => [:create, :edit, :update, :destroy]

  before_filter :set_container
  before_filter :set_next, :except => [:index, :new]
  helper :all
  protect_from_forgery
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end

  def self.json_search
    class_eval "
      respond_to :json, :only => :index
      has_scope :search, :as => :term
      def index
        index! do |format|
          format.json { render :json => resource_class.to_autocomplete(collection) }
        end
      end"
  end
  ALL_ACTIONS = [:index, :new, :create, :edit, :update, :destroy, :show]

  def self.has_instance_variable(name, options={})
    as = options[:as] || "#{name}_id".to_sym
    klass = (options[:class_name] || name.to_s.camelize).constantize
    class_eval do
      before_filter "load_#{name}".to_sym, options.slice(:except, :only)
      define_method "load_#{name}", lambda {
        if params[as]
          obj = klass.find(params[as])
          instance_variable_set("@#{name}", obj)
        end
      }
      if options[:for_resource]
        actions = ALL_ACTIONS.minus([:index, options[:except]].flatten)
        actions.only! options[:only] if options[:only]
        actions.each do |action|
          define_method action, lambda {
            self.send "#{action}!".to_sym do |format|
              resource.send("#{name}=", instance_variable_get("@#{name}"))
            end
          }
        end
      end
    end
  end

  def self.authorized
    class_eval do
      def resource
        authorize! super, params[:action] unless @authorized
        @authorized = true
        super
      end
    end
  end

  def set_container
    @container = params[:container] || 'main_container'
    @show_title = (@container=='main_container')
    @ajax_function = params[:ajax_function] || 'html'
  end

  def set_next
    @next = resource_class.where("id > #{params[:id]}").order(:id).limit(1).first if params[:id]
    @next ||= resource_class.first
  end


#  require "prawn/measurement_extensions"
#  prawnto :prawn => {
#              :left_margin => 8.mm,
#              :right_margin => 8.mm,
#              :top_margin => 5.mm,
#              :bottom_margin => 5.mm}
#  def page
#    [[nil, nil, nil],[nil, nil, nil],[nil, nil, nil],[nil, nil, nil]]
#  end

#  def self.acts_as_taggable(klass)
#    class_eval "def tag; @#{klass.name.tableize} = #{klass.name}.tagged_with(params[:id], :on => :tags);render :template => \"index\";end;"
#  end
#
#  def self.acts_as_taggable_on(klass, *contexts)
#    contexts.each do |context|
#      class_eval "def #{context.to_s.singularize}; @#{klass.name.tableize} = #{klass.name}.tagged_with(params[:id], :on => :#{context.to_s});render :template => \"index\";end;"
#    end
#  end

  private
end

