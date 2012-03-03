class HomeController < ApplicationController
  def index
    @snippets = SnippetsController::Snippet.all
    @articles = ArticlesController::Article.all
  end
end
