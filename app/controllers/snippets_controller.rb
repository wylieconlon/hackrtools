class SnippetsController < ItemsController
  # GET  /items
  # POST /items
  # POST /items.json
  def create
    puts "Saving snippet: #{params}"
    
    params[:item][:type] = "Snippet"
    
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
    @item = Item.find(params[:id])
    render :layout => false
  end
end
