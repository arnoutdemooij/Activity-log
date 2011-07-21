class ArticlesController < ApplicationController
  load_and_authorize_resource  

  # GET /articles
  # GET /articles.xml
  def index
#    @articles = current_user.articles  # Article.all
    @articles = Article.find(:all, :conditions => { :user_id => current_user.friendships.collect(&:friend_id) << current_user.id }, :order => :activity_date)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.xml
  def show
    @article = Article.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.xml
  def new
    @article = Article.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @article }
    end
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find(params[:id])
  end

  # POST /articles
  # POST /articles.xml
  def create
    @article = current_user.articles.build(params[:article])

    respond_to do |format|
      if @article.save
        tweet if @article.generate_tweet == '1'

        format.html { redirect_to(@article, :notice => 'Article was successfully created.') }
        format.xml  { render :xml => @article, :status => :created, :location => @article }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.xml
  def update
    @article = Article.find(params[:id])

    respond_to do |format|
      if @article.update_attributes(params[:article])
        tweet if @article.generate_tweet == '1'

        format.html { redirect_to(@article, :notice => 'Article was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.xml
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to(articles_url) }
      format.xml  { head :ok }
    end
  end

  private

  def tweet
    Twitter.configure do |config|
      config.consumer_key = '0DOxCtTOsWTdQQ3nrkbw'
      config.consumer_secret = 'HSZXSYSKczcsHsFeSRNKFGIi1Wqf8SCROsMB6NXA'
      config.oauth_token = current_user.token
      config.oauth_token_secret = current_user.secret
    end

    Twitter.update(@article.activity_date.to_s + ': ' + @article.content)
  end

end
