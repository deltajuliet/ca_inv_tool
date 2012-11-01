class UploadsController < ApplicationController
  def index
    @upload = Upload.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @upload }
    end
  end

  def create
    @upload = Upload.new
    post = @upload.parse_inventory_file(params[:upload])
    render :inline => "<p>File has been uploaded successfully<br /><br />Please wait while inventory is added to database...</p>"
    @upload.add_items_to_database
    @upload.cleanup
    render :inline => "<p>Inventory added successfully<br /><br /><%= link_to 'Go Home', welcome_index_path %></p>"
  end

  def add_inventory

  end
end
