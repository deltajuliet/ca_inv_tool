class CreateScans < ActiveRecord::Migration
  def change
    create_table :scans do |t|
      t.string :title
      t.boolean :finished
      t.boolean :imported

      t.timestamps
    end
  end
end
