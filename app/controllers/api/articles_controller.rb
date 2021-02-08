class Api::ArticlesController < ApplicationController
  def index
    articles_from_database = Article.all
    render json: { articles: articles_from_database }
  end

  def show
    article_from_database = Article.find(params['id'])
    render json: { article: article_from_database }
  end
end
