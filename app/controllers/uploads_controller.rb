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
    post = @upload.parse_inventory_file(params[:uploads])
    render :text => "File has been uploaded successfully"
  end
end
