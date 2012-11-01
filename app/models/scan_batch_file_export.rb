class ScanBatchFileExport < ActiveRecord::Base
  attr_accessible :export_name, :scan_id

  def export_to_csv(scan_id)
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

    scan_details = Scan.find(scan_id)
    inventory_items = InventoryItem.all

    scan_data = ScanItem.find_all_by_scan_id(scan_id)
    puts scan_data.inspect

    csv = CSV.generate(:force_quotes => true) do |line|
      csv << @column_names
      scan_data.each do |item|
        inventory_items.each do |inv_item|
          if item.item_sku == inv_item.inventory_number
            csv << [inv_item.auction_title,inv_item.inventory_number,"RELATIVE",item.quantity,inv_item.weight,inv_item.upc,inv_item.asin,inv_item.mpn,inv_item.description,inv_item.brand,inv_item.starting_bid,inv_item.seller_cost,inv_item.buy_it_now_price,inv_item.retail_price,inv_item.channel_advisor_store_price,inv_item.second_chance_offer_price,inv_item.picture_urls,inv_item.received_in_inventory,inv_item.labels,inv_item.flag,inv_item.classification]
          end
        end
      end
    end

    send_data csv,
              :type => 'text/csv; charset=iso-8859-1; header=present',
              :disposition => "attachment; filename=#{scan_details.title}-#{Time.now.strftime('%d-%m-%y--%H-%M')}.csv"
  end

end
