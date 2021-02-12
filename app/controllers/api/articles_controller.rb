class Api::ArticlesController < ApplicationController
  def index
    articles_from_database = Article.all
    render json: { articles: articles_from_database }
  end

  def show
    article_from_database = Article.find(params['id'])
    render json: { article: article_from_database }
  end

  def create
    article = Article.create(article_params)
    if article.persisted?
      render json: { message: 'The article was successfully saved'}, status: 201
    else
      render json: { message: article.errors.full_messages.to_sentence }, status: 422
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
