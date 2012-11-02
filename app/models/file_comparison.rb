class FileComparison < ActiveRecord::Base
  attr_accessible :ca_inv_filename, :scanned_inv_filename
  attr_reader :csv_data

  def run_comparison(ca_filename, scanned_filename)
    parse_ca_inventory_file(ca_filename)
    parse_scanned_inventory_file(scanned_filename)
    @ca_inv_array = []
    @scanned_inv_array = []
    parse_file(@ca_inv_filename, 'ca_file')
    parse_file(@scanned_inv_filename, 'scanned_file')
    cleanup(@ca_inv_filename)
    cleanup(@scanned_inv_filename)
    compare
  end

  def parse_ca_inventory_file(compare)
    name = compare['ca_inv_filename'].original_filename
    directory = "public"
    # create the file path
    path = File.join(directory, name)
    @ca_inv_filename = path
    # write the file
    File.open(path, "wb") { |f| f.write(compare['ca_inv_filename'].read) }
  end

  def parse_scanned_inventory_file(compare)
    name = compare['scanned_inv_filename'].original_filename
    directory = "public"
    # create the file path
    path = File.join(directory, name)
    @scanned_inv_filename = path
    # write the file
    File.open(path, "wb") { |f| f.write(compare['scanned_inv_filename'].read) }
  end

  def parse_file(filename, type)

    inv_file = File.open(filename, 'r')

    converted_inv_file = []

    if type == "ca_file"

      inv_file.each do |line|
        conv_line = line.encode('UTF-16le', :invalid => :replace, :replace => '').encode('UTF-8')
        converted_inv_file.push(conv_line)
      end

      first_line = converted_inv_file.shift

      header_hash = {
          :auction_title => nil,
          :inventory_number => nil,
          :total_quantity => nil,
          :quantity => nil,
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
      first_line.split(/\t/).each do |column|
        case column
          when /.Auction Title|Auction Title/
            header_hash[:auction_title] = column_counter
          when "Inventory Number"
            header_hash[:inventory_number] = column_counter
          when "Total Quantity"
            header_hash[:total_quantity] = column_counter
          when "Quantity"
            header_hash[:quantity] = column_counter
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
        row = line.split(/\t/)

        item = {}
        item[:auction_title] = row[header_hash[:auction_title]]
        item[:inventory_number] = row[header_hash[:inventory_number]]
        item[:total_quantity] = row[header_hash[:total_quantity]]
        item[:weight] = row[header_hash[:weight]] unless header_hash[:weight].nil?
        item[:upc] = row[header_hash[:upc]] unless header_hash[:upc].nil?
        item[:asin] = row[header_hash[:asin]] unless header_hash[:asin].nil?
        item[:mpn] = row[header_hash[:mpn]] unless header_hash[:mpn].nil?
        item[:description] = row[header_hash[:description]] unless header_hash[:description].nil?
        item[:brand] = row[header_hash[:brand]] unless header_hash[:brand].nil?
        item[:starting_bid] = row[header_hash[:starting_bid]] unless header_hash[:starting_bid].nil?
        item[:seller_cost] = row[header_hash[:seller_cost]] unless header_hash[:seller_cost].nil?
        item[:buy_it_now_price] = row[header_hash[:buy_it_now_price]] unless header_hash[:buy_it_now_price].nil?
        item[:retail_price] = row[header_hash[:retail_price]] unless header_hash[:retail_price].nil?
        item[:channel_advisor_store_price] = row[header_hash[:channeladvisor_store_price]] unless header_hash[:channeladvisor_store_price].nil?
        item[:second_chance_offer_price] = row[header_hash[:second_chance_offer_price]] unless header_hash[:second_chance_offer_price].nil?
        item[:picture_urls] = row[header_hash[:picture_urls]] unless header_hash[:picture_urls].nil?
        item[:received_in_inventory] = row[header_hash[:received_in_inventory]] unless header_hash[:received_in_inventory].nil?
        item[:labels] = row[header_hash[:labels]] unless header_hash[:labels].nil?
        item[:flag] = row[header_hash[:flags]] unless header_hash[:flags].nil?
        item[:classification] = row[header_hash[:classification]] unless header_hash[:classification].nil?

        @ca_inv_array.push(item)
      end

    elsif type == "scanned_file"
      #SCANNED FILE TYPE

      puts "Beginning scanned file"

      header_hash = {
          :auction_title => nil,
          :inventory_number => nil,
          :total_quantity => nil,
          :quantity => nil,
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

      line_counter = 0
      CSV.foreach(filename) do |row|
        puts row.inspect
        if line_counter < 1
          column_counter = 0
          row.each do |column_header|
            case column_header
              when "Auction Title"
                header_hash[:auction_title] = column_counter
              when "Inventory Number"
                header_hash[:inventory_number] = column_counter
              when "Total Quantity"
                header_hash[:total_quantity] = column_counter
              when "Quantity"
                header_hash[:quantity] = column_counter
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
          line_counter += 1
        else
          item = {}
          item[:auction_title] = row[header_hash[:auction_title]]
          item[:inventory_number] = row[header_hash[:inventory_number]]
          item[:scanned_quantity] = row[header_hash[:quantity]]
          item[:weight] = row[header_hash[:weight]] unless header_hash[:weight].nil?
          item[:upc] = row[header_hash[:upc]] unless header_hash[:upc].nil?
          item[:asin] = row[header_hash[:asin]] unless header_hash[:asin].nil?
          item[:mpn] = row[header_hash[:mpn]] unless header_hash[:mpn].nil?
          item[:description] = row[header_hash[:description]] unless header_hash[:description].nil?
          item[:brand] = row[header_hash[:brand]] unless header_hash[:brand].nil?
          item[:starting_bid] = row[header_hash[:starting_bid]] unless header_hash[:starting_bid].nil?
          item[:seller_cost] = row[header_hash[:seller_cost]] unless header_hash[:seller_cost].nil?
          item[:buy_it_now_price] = row[header_hash[:buy_it_now_price]] unless header_hash[:buy_it_now_price].nil?
          item[:retail_price] = row[header_hash[:retail_price]] unless header_hash[:retail_price].nil?
          item[:channel_advisor_store_price] = row[header_hash[:channeladvisor_store_price]] unless header_hash[:channeladvisor_store_price].nil?
          item[:second_chance_offer_price] = row[header_hash[:second_chance_offer_price]] unless header_hash[:second_chance_offer_price].nil?
          item[:picture_urls] = row[header_hash[:picture_urls]] unless header_hash[:picture_urls].nil?
          item[:received_in_inventory] = row[header_hash[:received_in_inventory]] unless header_hash[:received_in_inventory].nil?
          item[:labels] = row[header_hash[:labels]] unless header_hash[:labels].nil?
          item[:flag] = row[header_hash[:flags]] unless header_hash[:flags].nil?
          item[:classification] = row[header_hash[:classification]] unless header_hash[:classification].nil?
          puts item.inspect
          @scanned_inv_array.push(item)
          line_counter += 1
        end
      end
    end

  end

  def return_wrong_qtys(array_of_wrong_skus)
    @column_names = [
        "Auction Title",
        "Inventory Number",
        "Quantity Update Type",
        "Quantity",
        "Old Quantity [DELETE ME]",
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

    csv = CSV.generate(:force_quotes => true) do |line|
      line << @column_names
      array_of_wrong_skus.each do |item|
        ca_inv_item = InventoryItem.find_by_inventory_number(item[:inventory_number])
        puts "DETECTED WRONG QTY"
        puts item
          column_data = [
            item[:auction_title],
            item[:inventory_number],
            "ABSOLUTE",
            item[:scanned_quantity],
            ca_inv_item.total_quantity,
            item[:weight],
            item[:upc],
            item[:asin],
            item[:mpn],
            item[:description],
            item[:brand],
            item[:starting_bid],
            item[:seller_cost],
            item[:buy_it_now_price],
            item[:retail_price],
            item[:channel_advisor_store_price],
            item[:second_chance_offer_price],
            item[:picture_urls],
            item[:received_in_inventory],
            item[:labels],
            item[:flag],
            item[:classification]]
        line << column_data
      end
    end

    return csv
  end

  def compare
    @items_with_wrong_qty = []
    puts "COMPARING NOW"
    puts @scanned_inv_array.inspect
    @scanned_inv_array.each do |scanned_item|
      @ca_inv_array.each do |ca_item|
        if scanned_item[:inventory_number] == ca_item[:inventory_number]
          if scanned_item[:quantity] != ca_item[:total_quantity]
            @items_with_wrong_qty.push(scanned_item)
          end
        end
      end
    end

    return_wrong_qtys(@items_with_wrong_qty)
  end

  def cleanup(filename)
    File.delete(filename)
  end
end
