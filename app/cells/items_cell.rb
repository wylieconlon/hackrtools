class ItemsCell < Cell::Rails
  def list(args)
    @items = args[:items]
    
    return render
  end
end