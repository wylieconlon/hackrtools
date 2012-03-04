class ItemsController < ApplicationController
  before_filter :authenticate_user!
  skip_before_filter :authenticate_user!, :only => [:index, :show, :add]

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


  # Returns posts tagged with all of the given tags
  # GET /items/tagged/ruby-on-rails+web-development+web-design
  # GET /items/tagged/ruby-on-rails+web-development+web-design.json
  def tagged
    @tags = params[:tags]
    @tags = @tags.split("+").collect { |t| t.split("-").join(" ") }
    @items = Item.tagged_with(@tags, :any => true)

    respond_to do |format|
      format.html # tagged.html.erb
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

  # GET /add/:type/uid=:uid&title=:title&link=:link&public=:public&type=:type&code=:code
  # Expects: uid      int     The user's email
  #          link     string  The item link
  #          public   bool    Is the item public?
  #          code     string  The code for this item (if it is a snippet)
  #          tags     string  A list of tags (ruby-on-rails+web-development)
  #
  def add
    @user = User.self.where("email = ?", params[:uid])
    @item = Item.new(:title => params[:title], :link => params[:link],
                     :public => params[:public], :type => params[:type],
                     :code => params[:code], :tags => params[:tags])

    @item.user = @user

    respond_to do |format|
      if @item.save
        format.html { redirect_to root_url_path, notice: 'Item was successfully updated.' }
        format.json { render json: @item }
      else
        format.html { render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
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
