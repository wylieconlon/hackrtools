class ItemCell < Cell::Rails
  def show(args)
    @item = args[:item]
    
    render
  end
end