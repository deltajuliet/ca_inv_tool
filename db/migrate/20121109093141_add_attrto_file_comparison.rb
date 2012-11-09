class AddAttrtoFileComparison < ActiveRecord::Migration
  def up
    add_column :file_comparisons, :include_ca_zeros, :boolean
  end

  def down
  end
end
