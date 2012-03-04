class HomeController < ApplicationController
  def index
    # show dashboard for authenticated users
    if signed_in?
    	@items = Item.all
    	render 'items/index'
    end
    
    # otherwise go to splash page
  end
end
