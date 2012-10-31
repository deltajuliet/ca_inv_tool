class RenameInventoryFileToUpload < ActiveRecord::Migration
  def up
    rename_table :inventory_files, :uploads
  end

  def down
    rename_table :uploads, :inventory_files
  end
end
