class CreateInventoryItems < ActiveRecord::Migration
  def change
    create_table :inventory_items do |t|
      t.string :auction_title
      t.string :inventory_number
      t.integer :total_quantity
      t.float :weight
      t.string :upc
      t.string :asin
      t.string :mpn
      t.text :description
      t.string :brand
      t.decimal :starting_bid
      t.decimal :seller_cost
      t.decimal :buy_it_now_price
      t.decimal :retail_price
      t.decimal :channel_advisor_store_price
      t.decimal :second_chance_offer_price
      t.string :picture_urls
      t.integer :received_in_inventory
      t.string :labels
      t.string :flag
      t.string :classification

      t.timestamps
    end
  end
end
