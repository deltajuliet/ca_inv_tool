class ScanBatchFileExportsController < ApplicationController
  def index
    @scan_batch = ScanBatchFileExport.new

    @finished_scans = Scan.find_all_by_finished(true)

    respond_to do |format|
        format.html
    end
  end

  #def create
  #  @scan_id = params["scan_batch_file_export"]["scan_id"]
  #
  #  @scan = Scan.find(@scan_id)
  #
  #  scan_data = ScanItem.find_all_by_scan_id(@scan_id)
  #  puts scan_data.inspect
  #
  #  @scan_batch_export = ScanBatchFileExport.new
  #
  #  respond_to do |format|
  #    format.html
  #    format.csv {@scan_batch_export.export_to_csv(@scan_id)}
  #  end
  #end

  def create
    @scan_id = params["scan_batch_file_export"]["scan_id"]
    @export_type = params["scan_batch_file_export"]["export_name"]

    @scan = Scan.find(@scan_id)

    @column_names = [
        "Auction Title",
        "Inventory Number",
        "Quantity Update Type",
        "Quantity",
        "Weight",
        "UPC",
        "ASIN",
        "MPN",
        "Description",
        "Brand",
        "Starting Bid",
        "Seller Cost",
        "Buy It Now Price",
        "Retail Price",
        "ChannelAdvisor Store Price",
        "Second Chance Offer Price",
        "Picture URLs",
        "Received In Inventory",
        "Labels",
        "Flag",
        "Classification"
    ]

    puts scan_details = Scan.find(@scan_id)
    inventory_items = InventoryItem.all

    scan_data = ScanItem.find_all_by_scan_id(@scan_id)
    puts scan_data.inspect

    #respond_to do |format|
    #  format.html
    #end

    filename = ""

    if @export_type == "In Inventory"
      filename = "#{scan_details.title}-InInventory-#{Time.now.strftime('%m_%d_%y-%H%M')}.csv"
    else
      filename = "#{scan_details.title}-NotInInventory-#{Time.now.strftime('%m_%d_%y-%H%M')}.csv"
    end

    csv = CSV.generate(:force_quotes => true) do |line|
      line << @column_names
      puts @column_names
      scan_data.each do |item|
        if @export_type == "In Inventory"
          inventory_items.each do |inv_item|
            if item.item_sku == inv_item.inventory_number
              column_data = [
                  inv_item.auction_title,
                  inv_item.inventory_number,
                  "RELATIVE",
                  item.quantity,
                  inv_item.weight,
                  inv_item.upc,
                  inv_item.asin,
                  inv_item.mpn,
                  inv_item.description,
                  inv_item.brand,
                  inv_item.starting_bid,
                  inv_item.seller_cost,
                  inv_item.buy_it_now_price,
                  inv_item.retail_price,
                  inv_item.channel_advisor_store_price,
                  inv_item.second_chance_offer_price,
                  inv_item.picture_urls,
                  inv_item.received_in_inventory,
                  inv_item.labels,
                  inv_item.flag,
                  inv_item.classification]
              puts column_data
              line << column_data
            end
          end
        else
          column_data = [
              "",
              item.item_sku,
              "RELATIVE",
              item.quantity,
              "",
              "",
              "",
              "",
              "",
              "",
              "",
              "",
              "",
              "",
              "",
              "",
              "",
              "",
              "",
              "",
              ""]
          puts column_data unless item.in_inventory
          line << column_data unless item.in_inventory
        end
      end
    end

    send_data csv,
              :type => 'text/csv; charset=iso-8859-1; header=present',
              :disposition => "attachment; filename=#{filename}"
  end
end