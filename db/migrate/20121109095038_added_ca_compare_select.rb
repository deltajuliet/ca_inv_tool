class AddedCaCompareSelect < ActiveRecord::Migration
  def up
    add_column :file_comparisons, :include_ca_compare, :string
  end

  def down
  end
end
