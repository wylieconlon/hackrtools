class ArticlesController < ItemsController
  # POST /items
  # POST /items.json
  def create
    puts "Saving article: #{params}"
    
    params[:item][:type] = "Article"
    
    @item = Item.new(params[:item])
    
    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render json: @item, status: :created, location: @item }
      else
        format.html { render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def form
    render :text => "This is my articles form"
  end
end
