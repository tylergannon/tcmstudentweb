class SearchesController < ApplicationController
  respond_to :html, :js
  def index
    redirect_to "/" unless params.has_key?(:term)

    con,name,action = params[:term].split("/")
    if con.size>1
      controller = con.tableize
    else
      controller = CONTROLLERS[con]
    end
    unless controller
      flash[:notice] = "I don't understand the search term"
      redirect_to '/'
      return
    end

    #  acu_points/1/edit
    #  acu_points/sj-5/edit
    #  acu_points  => #index
    #  a           => #index
    #  a/sj-5      => #show
    #  a/new       => #new
    #  a/wai       => #index?term=wai
    klass = controller.singularize.camelize.constantize

    logger.error "Searching for #{klass.name}: #{name}"

    params = {:controller=>controller}
    if name=="new"
      params[:action] = "new"
    elsif name.nil?
      params[:action] = "index"
    elsif (obj = klass.named(name))
      params[:id] = obj.id
      params[:action] = action || "show"
    else
      params[:action] = "index"
      params[:term] = name
    end

    redirect_to params
  end

  CONTROLLERS = {
    "a" => "acu_points",
    "p" => "patterns",
    "t" => "articles",
    "f" => "formulas",
    "h" => "herbs",
    "c" => "channels",
    "s" => "symptoms"
    }
end

