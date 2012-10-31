class ScanItem < ActiveRecord::Base
  attr_accessible :in_inventory, :item_sku, :quantity
end
