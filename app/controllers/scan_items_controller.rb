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
    @scan_item = ScanItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @scan_item }
    end
  end

  # GET /scan_items/new
  # GET /scan_items/new.json
  def new
    @scan_item = ScanItem.new

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
    @scan_item = ScanItem.new(params[:scan_item])

    respond_to do |format|
      if @scan_item.save
        format.html { redirect_to @scan_item, :notice => 'Scan item was successfully created.' }
        format.json { render :json => @scan_item, :status => :created, :location => @scan_item }
      else
        format.html { render :action => "new" }
        format.json { render :json => @scan_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /scan_items/1
  # PUT /scan_items/1.json
  def update
    @scan_item = ScanItem.find(params[:id])

    respond_to do |format|
      if @scan_item.update_attributes(params[:scan_item])
        format.html { redirect_to @scan_item, :notice => 'Scan item was successfully updated.' }
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
    @scan_item = ScanItem.find(params[:id])
    @scan_item.destroy

    respond_to do |format|
      format.html { redirect_to scan_items_url }
      format.json { head :no_content }
    end
  end
end
