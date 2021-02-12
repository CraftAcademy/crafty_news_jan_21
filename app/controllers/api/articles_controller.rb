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
      render json: { message: 'The article was successfully saved' }, status: 201
    else
      render json: { message: article.errors.full_messages.to_sentence }, status: 422
    end
  end

  def update
    article = Article.find(params['id'])
    article.update(article_params)
    render json: { message: 'The article was successfully updated' }
  rescue ActiveRecord::RecordNotFound => error
    render json: { message: error.message }, status: 404

  rescue StandardError => error
    render json: { message: "Something went wrong, #{error.message}" }, status: 422
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
