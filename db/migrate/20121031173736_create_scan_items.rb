class CreateScanItems < ActiveRecord::Migration
  def change
    create_table :scan_items do |t|
      t.string :item_sku
      t.integer :quantity
      t.boolean :in_inventory

      t.timestamps
    end
  end
end
