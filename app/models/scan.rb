class Scan < ActiveRecord::Base
  attr_accessible :finished, :imported, :title
  attr_readonly :id
  attr_accessor :last_in_inventory, :last_inventory_number, :last_message

  has_many :scan_items, :dependent => :destroy

  def add_scan_message_info(in_inventory, inventory_number)
    @last_in_inventory = in_inventory
    @last_inventory_number = inventory_number
    @last_inventory_title = InventoryItem.find_by_inventory_number(inventory_number).auction_title

    if @last_in_inventory
      @last_message = "Last Item is already in Inventory! (#{@last_inventory_title})"
    else
      @last_message = "Not in Inventory!"
    end
  end
end
