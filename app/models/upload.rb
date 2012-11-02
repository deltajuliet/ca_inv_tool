class Upload < ActiveRecord::Base
  attr_accessible :filename

  def parse_inventory_file(upload)
    name =  upload['upload'].original_filename
    directory = "public"
    # create the file path
    path = File.join(directory, name)
    @filename = path
    # write the file
    File.open(path, "wb") { |f| f.write(upload['upload'].read) }
    add_items_to_database
  end

  def add_items_to_database
    ActiveRecord::Base.connection.execute("TRUNCATE inventory_items")
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE inventory_items_id_seq RESTART WITH 1")

    inv_file = File.open(@filename, 'r')

    converted_inv_file = []

    inv_file.each do |line|
      conv_line = line.encode('UTF-16le', :invalid => :replace, :replace => '').encode('UTF-8')
      converted_inv_file.push(conv_line)
    end

    first_line = converted_inv_file.shift

    header_hash = {
        :auction_title => nil,
        :inventory_number => nil,
        :total_quantity => nil,
        :weight => nil,
        :upc => nil,
        :asin => nil,
        :mpn => nil,
        :description => nil,
        :brand => nil,
        :starting_bid => nil,
        :seller_cost => nil,
        :buy_it_now_price => nil,
        :retail_price => nil,
        :channeladvisor_store_price => nil,
        :second_chance_offer_price => nil,
        :picture_urls =>nil,
        :received_in_inventory => nil,
        :labels => nil,
        :flag => nil,
        :classification => nil
    }

    column_counter = 0
    puts first_line.inspect
    first_line.split(/\t/).each do |column|
      case column
        when /.Auction Title|Auction Title/
          header_hash[:auction_title] = column_counter
        when "Inventory Number"
          header_hash[:inventory_number] = column_counter
        when "Total Quantity"
          header_hash[:total_quantity] = column_counter
        when "Weight"
          header_hash[:weight] = column_counter
        when "UPC"
          header_hash[:upc] = column_counter
        when "ASIN"
          header_hash[:asin] = column_counter
        when "MPN"
          header_hash[:mpn] = column_counter
        when "Description"
          header_hash[:description] = column_counter
        when "Brand"
          header_hash[:brand] = column_counter
        when "Starting Bid"
          header_hash[:starting_bid] = column_counter
        when "Seller Cost"
          header_hash[:seller_cost] = column_counter
        when "Buy It Now Price"
          header_hash[:buy_it_now_price] = column_counter
        when "Retail Price"
          header_hash[:retail_price] = column_counter
        when "ChannelAdvisor Store Price"
          header_hash[:channeladvisor_store_price] = column_counter
        when "Second Chance Offer Price"
          header_hash[:second_chance_offer_price] = column_counter
        when "Picture URLs"
          header_hash[:picture_urls] = column_counter
        when "Received In Inventory"
          header_hash[:received_in_inventory] = column_counter
        when "Labels"
          header_hash[:labels] = column_counter
        when "Flag"
          header_hash[:flag] = column_counter
        when "Classification"
          header_hash[:classification] = column_counter
      end
      column_counter += 1
    end

    converted_inv_file.each do |line|
      split_line = line.split(/\t/)

      item = InventoryItem.new
      
      item.auction_title = split_line[header_hash[:auction_title]]
      item.inventory_number = split_line[header_hash[:inventory_number]]
      item.total_quantity = split_line[header_hash[:total_quantity]]
      item.weight = split_line[header_hash[:weight]] unless header_hash[:weight].nil?
      item.upc = split_line[header_hash[:upc]] unless header_hash[:upc].nil?
      item.asin = split_line[header_hash[:asin]] unless header_hash[:asin].nil?
      item.mpn = split_line[header_hash[:mpn]] unless header_hash[:mpn].nil?
      item.description = split_line[header_hash[:description]] unless header_hash[:description].nil?
      item.brand = split_line[header_hash[:brand]] unless header_hash[:brand].nil?
      item.starting_bid = split_line[header_hash[:starting_bid]] unless header_hash[:starting_bid].nil?
      item.seller_cost = split_line[header_hash[:seller_cost]] unless header_hash[:seller_cost].nil?
      item.buy_it_now_price = split_line[header_hash[:buy_it_now_price]] unless header_hash[:buy_it_now_price].nil?
      item.retail_price = split_line[header_hash[:retail_price]] unless header_hash[:retail_price].nil?
      item.channel_advisor_store_price = split_line[header_hash[:channeladvisor_store_price]] unless header_hash[:channeladvisor_store_price].nil?
      item.second_chance_offer_price = split_line[header_hash[:second_chance_offer_price]] unless header_hash[:second_chance_offer_price].nil?
      item.picture_urls = split_line[header_hash[:picture_urls]] unless header_hash[:picture_urls].nil?
      item.received_in_inventory = split_line[header_hash[:received_in_inventory]] unless header_hash[:received_in_inventory].nil?
      item.labels = split_line[header_hash[:labels]] unless header_hash[:labels].nil?
      item.flag = split_line[header_hash[:flags]] unless header_hash[:flags].nil?
      item.classification = split_line[header_hash[:classification]] unless header_hash[:classification].nil?

      item.save
    end
    cleanup
  end

  def cleanup
    File.delete(@filename)
  end

end
