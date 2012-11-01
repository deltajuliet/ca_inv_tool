class AddScanBatchToScanItem < ActiveRecord::Migration
  def change
    add_column :scan_items, :scan_batch_id, :integer
  end
end
