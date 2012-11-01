class ScanItem < ActiveRecord::Base
  attr_accessible :in_inventory, :item_sku, :quantity, :scan_id
  attr_accessor :auction_title

  belongs_to :scan

  def import_scan(scan_id)

  end

  def item_exists?
    @in_inventory = false
    inventory_items = InventoryItem.all

    inventory_items.each do |item|
      if item.inventory_number == @item_sku
        @in_inventory = true
      end
    end
  end

  def get_item_title
    @auction_title = InventoryItem.find_by_inventory_number(@item_sku).auction_title unless @item_sku.nil?
  end
end
