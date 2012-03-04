class ItemsController < ApplicationController
  before_filter :authenticate_user!
  skip_before_filter :authenticate_user!, :only => [:index, :show]

  before_filter :join_tag_list, :only => [:create, :update]

  # GET /items
  # GET /items.json
  def index
    @items = Item.all
    
    puts "#{@items}"
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/new
  # GET /items/new.json
  def new
    setup_sti_model
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
    split_tag_list
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :no_content }
    end
  end

  private
  def setup_sti_model
    # This lets us set the "type" attribute from forms and querystrings
    model = nil
    if !params[:item].blank? and !params[:item][:type].blank?
      model = params[:item].delete(:type).constantize.to_s
    end
    @item = Item.new(params[:item])
    @item.type = model
  end

  private
  def join_tag_list
    # Split the tags on spaces, join with commas
    params[:item][:tag_list] = params[:item][:tag_list].split(" ").join(", ")
  end

  def split_tag_list
    @item.tag_list = @item.tag_list.join(" ")
  end

end
