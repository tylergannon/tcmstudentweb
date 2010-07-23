# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  USER_NAME, PASSWORD = "tyler", "mr.c00l"

  before_filter :authenticate
  include Authentication
  helper :all
  protect_from_forgery
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end

  def self.your_basic_controller(options={})
    actions = options[:only] ? [options[:only]].flatten :
         [:index, :edit, :show, :new, :update, :create, :destroy]
    [options[:except]].flatten.each{|o| actions.delete(o)} if options[:except]
    class_name = self.name.gsub(/Controller/, '').underscore.split('/').last.singularize
    unless options[:controller_resource]
      options[:controller_resource] = TcmStudentWeb::Application::APP_CONFIG[:controller_resource]
    end

    valid_formats = options[:respond_to] ? [options[:respond_to]].flatten : [:html, :js]

    args = [valid_formats.reject{|t| t==:json}, options.slice(:only, :except)].flatten
    respond_to *args
    respond_to :json, :only => :index if valid_formats.include?(:json)
    load_and_authorize_resource options.slice(:only, :except, :controller_resource)

    json_response = "do |format|
      format.json { render :json => #{class_name.camelize}.to_autocomplete(@#{class_name.tableize}) }
    end" if valid_formats.include?(:json)

    class_eval "def index
      @#{class_name.tableize} = @#{class_name.tableize}.search(params[:term]) if params[:term]
      respond_with @#{class_name.tableize}
      respond_with(@#{class_name.tableize}) #{json_response}
    end" if actions.include?(:index)

    class_eval "def new
      respond_with @#{class_name.underscore}
    end" if actions.include?(:new)

    class_eval "def show
      respond_with @#{class_name.underscore}
    end" if actions.include?(:show)

    class_eval "def edit
      respond_with @#{class_name.underscore}
    end" if actions.include? :edit

    class_eval "def create
      logger.error \"@#{class_name.underscore}.save\"
      flash[:notice] = \"Successfully created new #{class_name.titleize}.\" if @#{class_name.underscore}.save
      respond_with @#{class_name.underscore}
    end" if actions.include? :create

    class_eval "def update
      flash[:notice] = \"#{class_name.titleize} was successfully updated.\" if @#{class_name.underscore}.update_attributes(params[:#{class_name.underscore}])
      respond_with @#{class_name.underscore}
    end" if actions.include? :update

    class_eval "def destroy
      flash[:notice] = \"Successfully destroyed the #{class_name.titleize}\" if @#{class_name.underscore}.destroy
      respond_with @#{class_name.underscore}
    end" if actions.include? :destroy
  end

  helper_method :current_user_session, :current_user

  require "prawn/measurement_extensions"
  prawnto :prawn => {
              :left_margin => 8.mm,
              :right_margin => 8.mm,
              :top_margin => 5.mm,
              :bottom_margin => 5.mm}
  def page
    [[nil, nil, nil],[nil, nil, nil],[nil, nil, nil],[nil, nil, nil]]
  end

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
    def authenticate
      authenticate_or_request_with_http_basic do |user_name, password|
        user_name == USER_NAME && password == PASSWORD
      end
    end
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end

    def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to new_user_session_url
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to account_url
        return false
      end
    end

    def store_location
      session[:return_to] = request.request_uri
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
end

