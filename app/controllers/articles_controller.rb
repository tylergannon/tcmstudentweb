class ArticlesController < ApplicationController
  respond_to :html

  def index
    if params.has_key?(:tag_name)
      @articles = Article.tagged_with(params[:tag_name].to_list)
    else
      @articles = Article.all
    end

    @tags = Article.tag_counts_on(:tags)
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

  # GET /articles/1
  # GET /articles/1.xml
  def show
    @article = Article.lookup(params)
    respond_with @article
  end

  # GET /articles/new
  # GET /articles/new.xml
  def new
    @article = Article.new
    @article.title = params[:name]
    respond_with @article
  end

  # GET /articles/1/edit
  def edit
    @article = Article.lookup(params)
  end

  # POST /articles
  # POST /articles.xml
  def create
    @article = Article.new(params[:article])
    @article.save
    respond_with @article
  end

  # PUT /articles/1
  # PUT /articles/1.xml
  def update
    @article = Article.lookup(params)
    @article.update_attributes(params[:article])
    respond_with @article
  end

  # DELETE /articles/1
  # DELETE /articles/1.xml
  def destroy
    @article = Article.lookup(params)
    @article.destroy
    respond_with @article
  end
end

