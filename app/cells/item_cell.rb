class ItemCell < Cell::Rails
  def show(args)
    @item = args[:item]
    @hasCode = defined?(@item.code)
    # @timeAgo = time_ago_in_words(args[:item][:updated_at])
    
    render
  end
  
  def form(args)
    @item = args[:item]
    @hasCode = args[:type] == "Snippet"
    
    render
  end
end