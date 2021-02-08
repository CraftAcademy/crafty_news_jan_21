class Api::ArticlesController < ApplicationController
  def index
    articles_from_database = Article.all
    render json: { articles: articles_from_database }
  end

  def show
    
  end
end
