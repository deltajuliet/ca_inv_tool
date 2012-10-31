class InventoryItemsController < ApplicationController
  # GET /inventory_items
  # GET /inventory_items.json
  def index
    @inventory_items = InventoryItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @inventory_items }
    end
  end

  # GET /inventory_items/1
  # GET /inventory_items/1.json
  def show
    @inventory_item = InventoryItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @inventory_item }
    end
  end

  # GET /inventory_items/new
  # GET /inventory_items/new.json
  def new
    @inventory_item = InventoryItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @inventory_item }
    end
  end

  # GET /inventory_items/1/edit
  def edit
    @inventory_item = InventoryItem.find(params[:id])
  end

  # POST /inventory_items
  # POST /inventory_items.json
  def create
    @inventory_item = InventoryItem.new(params[:inventory_item])

    respond_to do |format|
      if @inventory_item.save
        format.html { redirect_to @inventory_item, :notice => 'Inventory item was successfully created.' }
        format.json { render :json => @inventory_item, :status => :created, :location => @inventory_item }
      else
        format.html { render :action => "new" }
        format.json { render :json => @inventory_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /inventory_items/1
  # PUT /inventory_items/1.json
  def update
    @inventory_item = InventoryItem.find(params[:id])

    respond_to do |format|
      if @inventory_item.update_attributes(params[:inventory_item])
        format.html { redirect_to @inventory_item, :notice => 'Inventory item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @inventory_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /inventory_items/1
  # DELETE /inventory_items/1.json
  def destroy
    @inventory_item = InventoryItem.find(params[:id])
    @inventory_item.destroy

    respond_to do |format|
      format.html { redirect_to inventory_items_url }
      format.json { head :no_content }
    end
  end
end
