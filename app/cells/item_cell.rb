class ItemCell < Cell::Rails
  def show(args)
    @item = args[:item]
    @hasCode = defined?(@item.code)
    
    render
  end
  
  def form(args)
    @item = args[:item]
    @hasCode = args[:type] == "Snippet"
    
    render
  end
end