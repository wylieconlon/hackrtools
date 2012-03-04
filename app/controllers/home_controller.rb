class HomeController < ApplicationController
  def index
    @snippets = Snippet.all
    @articles = Article.all
  end
end
