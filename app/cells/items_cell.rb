class ItemsCell < Cell::Rails
  def list(args)
    @items = args[:items]
    
    render
  end
end