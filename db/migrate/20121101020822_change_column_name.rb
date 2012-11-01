class ChangeColumnName < ActiveRecord::Migration
  def up
    rename_column :scan_items, :scan_batch_id, :scan_id
  end

  def down
  end
end
