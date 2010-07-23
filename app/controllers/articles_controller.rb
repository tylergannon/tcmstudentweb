class ArticlesController < ApplicationController
  your_basic_controller :except=>[:index, :report]

  load_and_authorize_resource :only=>[:index], :controller_resource => 'load_behind/controller_resource'

  def index
    @articles = @articles.tagged_with(params[:tag_name].to_list) if params[:tag_name]
    @articles = @articles.search(params[:term]) if params[:term]

    @tags = @articles.tag_counts_on(:tags)
    respond_with @articles, @tags
  end

  def report
    @article = Article.lookup(params)
    @articles, @herbs, @patterns, @symptoms = [[],[],[],[]]

    @article.body.scan(/"(\w):([\w\s]+)"/m).each do |match|
      case match[0]
        when 'f'
          @articles.plus_if(Article.named(match[1]))
        when 'h'
          @herbs.plus_if(Herb.named(match[1]))
        when 'p'
          @patterns.plus_if(Pattern.named[match[1]])
        when 's'
          @symptoms.plus_if(Symptom.named[match[1]])
      end
    end

    @formulas_by_category = []
    ArticleCategory.find(:all, :order => "position").each do |cat|
      articlee = @articles.select{|f| f.article_category == cat}
      @articles_by_category << [cat, articlee] unless articlee.size==0
    end
    respond_with @article, @articles, @herbs, @patterns, @symptoms, @articles_by_category
  end

end

