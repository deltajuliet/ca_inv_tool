class ScanItem < ActiveRecord::Base
  attr_accessible :in_inventory, :item_sku, :quantity, :scan_id
  attr_accessor :auction_title, :message

  belongs_to :scan

  def self.get_item_title(sku)
    @auction_title = InventoryItem.find_by_inventory_number(sku).auction_title unless InventoryItem.find_by_inventory_number(sku).nil?
  end
end
