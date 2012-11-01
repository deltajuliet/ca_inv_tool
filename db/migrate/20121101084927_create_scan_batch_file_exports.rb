class CreateScanBatchFileExports < ActiveRecord::Migration
  def change
    create_table :scan_batch_file_exports do |t|

      t.timestamps
    end
  end
end
