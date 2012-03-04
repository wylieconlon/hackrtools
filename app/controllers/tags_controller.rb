class TagsController < ApplicationController
  def nearest
    query = params[:query]
    
    tags = ActsAsTaggableOn::Tag.where("tags.name LIKE ?", "%#{query}%") 
    
    respond_to do |format|
      format.json { render :json => @tags }
    end
  end
end
