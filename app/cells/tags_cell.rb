class TagsCell < Cell::Rails
  def tag_cloud(args)
    include ActsAsTaggableOn::TagsHelper
    
    @tags = Item.tag_counts_on(:tags)
    
    render
  end
end