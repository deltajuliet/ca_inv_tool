class Upload < ActiveRecord::Base
  attr_accessible :filename

  def parse_inventory_file(upload)
    name =  upload['upload'].original_filename
    directory = "public/data"
    # create the file path
    path = File.join(directory, name)
    puts "DAN!!! Path is: #{path}"
    # write the file
    File.open(path, "wb") { |f| f.write(upload['upload'].read) }
    add_items_to_database(path)
    File.delete(path)
  end

  def add_items_to_database(filepath)
    ActiveRecord::Base.connection.execute("TRUNCATE inventory_items")
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE inventory_items_id_seq RESTART WITH 1")

    inv_file = File.open(filepath, 'r')

    first_line = inv_file.first

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
    first_line.each do |column|
      case column
        when "Auction Title"
          header_hash[:auction_title] = column_counter
        when "Inventory Number"
        when "Total Quantity"
        when "Weight"
        when "UPC"
        when "ASIN"
        when "MPN"
        when "Description"
        when "Brand"
        when "Starting Bid"
        when "Seller Cost"
        when "Buy It Now Price"
        when "Retail Price"
        when "ChannelAdvisor Store Price"
        when "Second Chance Offer Price"
        when "Picture URLs"
        when "Received In Inventory"
        when "Labels"
        when "Flag"
        when "Classification"
      end
      column_counter += 1
    end

    inv_file.each_line do |line|
      puts line
    end
  end
end
