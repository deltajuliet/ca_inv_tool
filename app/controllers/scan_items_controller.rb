class ScanItemsController < ApplicationController
  # GET /scan_items
  # GET /scan_items.json
  def index
    @scan_items = ScanItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @scan_items }
    end
  end

  # GET /scan_items/1
  # GET /scan_items/1.json
  def show
    @scan_id = params["scan_id"]
    @scan_item = ScanItem.find(params[:id])

    respond_to do |format|
      format.html # create.html.erb
      format.json { render :json => @scan_item }
      format.csv {send_data @scan_item.to_csv(@scan_id)}
    end
  end

  # GET /scan_items/new
  # GET /scan_items/new.json
  def new
    @scan_id = params[:parent_scan_id].to_s.to_i
    @message = params[:message].to_s unless params[:message].nil?
    @item_in_inv = params[:item_in_inv].to_s unless params[:item_in_inv].nil?
    @scan_item = ScanItem.new

    #render 'scan_items/new'

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @scan_item }
    end
  end

  # GET /scan_items/1/edit
  def edit
    @scan_item = ScanItem.find(params[:id])
  end

  # POST /scan_items
  # POST /scan_items.json
  def create
    @scan_id = params[:parent_scan_id].to_s.to_i
    already_scanned = false

    scanned_sku = params["scan_item"]["item_sku"]
    scanned_items = ScanItem.find_all_by_scan_id(@scan_id)

    @scan_item = nil

    scanned_items.each do |i|
      @scan_item = i if i.item_sku == scanned_sku
    end

    puts @scan_item.inspect

    if @scan_item.nil?
      @scan_item = ScanItem.new
      @scan_item.item_sku = scanned_sku
      @scan_item.quantity = 1
      @scan_item.scan_id = @scan_id
    else
      already_scanned = true
      @scan_item.quantity += 1
    end

    @scan_item.in_inventory = false
    @scan_item.message = "NOT in Inventory! (#{@scan_item.item_sku})"
    inventory_items = InventoryItem.all

    inventory_items.each do |item|
      if item.inventory_number == @scan_item.item_sku
        @scan_item.in_inventory = true
        puts @scan_item.message = "Item Exists in Inventory: #{ScanItem.get_item_title(@scan_item.item_sku)}"
      end
    end

    @scan_item.save

    respond_to do |format|
        format.html { redirect_to new_scan_item_path(:parent_scan_id => @scan_id, :message => @scan_item.message, :item_in_inv => @scan_item.in_inventory), :notice => 'Scan item was successfully created.' }
        format.json { render :json => @scan_item, :status => :created, :location => @scan_item }
    end
  end

  # PUT /scan_items/1
  # PUT /scan_items/1.json
  def update
    @scan_item = ScanItem.find(params[:id])

    respond_to do |format|
      if @scan_item.update_attributes(params[:scan_item])
        format.html { redirect_to @scan_item.scan, :notice => 'Scan item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @scan_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /scan_items/1
  # DELETE /scan_items/1.json
  def destroy
    @scan_id = params[:parent_scan_id].to_s.to_i
    @scan_item = ScanItem.find(params[:id])
    @scan_item.destroy

    respond_to do |format|
      format.html { redirect_to scans_url }
      format.json { head :no_content }
    end
  end
end
