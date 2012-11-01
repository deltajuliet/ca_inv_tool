class ScanBatchFileExportsController < ApplicationController
  def index
    @scan_batch_export = ScanBatchFileExport.new

    respond_to do |format|
        format.html
        format.csv {send_data ScanBatchFileExport.to_csv(@scan_id)}
    end
  end

  def create
    @scan_id = params["scan_batch_file_export"]["scan_id"]
    @scan_batch_export = ScanBatchFileExport.new

    respond_to do |format|
      format.html
      format.csv {send_data ScanBatchFileExport.to_csv(@scan_id)}
    end
  end
end
