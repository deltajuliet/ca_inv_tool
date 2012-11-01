class CreateFileComparisons < ActiveRecord::Migration
  def change
    create_table :file_comparisons do |t|
      t.string :ca_inv_filename
      t.string :scanned_inv_filename

      t.timestamps
    end
  end
end
