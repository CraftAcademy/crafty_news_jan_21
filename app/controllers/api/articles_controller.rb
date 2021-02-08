class Api::ArticlesController < ApplicationController
  def index
    articles_from_database = Article.all
    # binding.pry
    render json: { articles: articles_from_database }
  end
end
