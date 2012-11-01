class ScanBatchFileExport < ActiveRecord::Migration
  def up
    add_column :scan_batch_file_exports, :export_name, :string
    add_column :scan_batch_file_exports, :scan_id, :integer
  end

  def down
  end
end
