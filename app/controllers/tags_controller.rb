class TagsController < ApplicationController
  def nearest
    query = params[:query]
    
    @tags = ActsAsTaggableOn::Tag.where("tags.name LIKE ?", "%#{query}%") 
    
    render :json => @tags.map{|t| { :name => t.name }}
  end
end
