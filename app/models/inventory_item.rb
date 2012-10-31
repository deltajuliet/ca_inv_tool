class InventoryItem < ActiveRecord::Base
  attr_accessible :asin, :auction_title, :brand, :buy_it_now_price, :channel_advisor_store_price, :classification, :description, :flag, :inventory_number, :labels, :mpn, :picture_urls, :received_in_inventory, :retail_price, :second_chance_offer_price, :seller_cost, :starting_bid, :total_quantity, :upc, :weight
end
