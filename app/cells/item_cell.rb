require 'csv'

class ItemCell < Cell::Rails
  include Devise::Controllers::Helpers
  
  helper_method :current_user

  def show(args)
    @item = args[:item]
    @hasCode = defined?(@item.code)
    # @timeAgo = time_ago_in_words(args[:item][:updated_at])
    
    @tags = @item.tags
    
    render
  end
  
  def form(args)
    @item = args[:item]
    @hideCode = args[:type] == "Article"
    
    render
  end
end