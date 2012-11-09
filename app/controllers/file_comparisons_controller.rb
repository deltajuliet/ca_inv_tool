class FileComparisonsController < ApplicationController
  def index
    @file_compare = FileComparison.new
  end

  def create
    @file_compare = FileComparison.new
    csv_data = @file_compare.run_comparison(params[:file_comparison])

    send_data csv_data,
              :type => 'text/csv; charset=iso-8859-1; header=present',
              :disposition => "attachment; filename=InInventoryWrongQty-#{Time.now.strftime('%m_%d_%y-%H%M')}.csv"

  end
end
