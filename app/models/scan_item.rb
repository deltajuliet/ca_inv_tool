class ScanItem < ActiveRecord::Base
  attr_accessible :in_inventory, :item_sku, :quantity, :scan_id
  attr_accessor :auction_title, :message

  belongs_to :scan

  def self.get_item_title(sku)
    @auction_title = InventoryItem.find_by_inventory_number(sku).auction_title unless InventoryItem.find_by_inventory_number(sku).nil?
  end

  def self.to_csv(scan_id)
    CSV.generate do |csv|
      csv << column_names
      all.each do |item|
        if item.scan_id == scan_id
        csv << product.attributes.values_at(*column_names)
        end
      end
    end
  end
end
