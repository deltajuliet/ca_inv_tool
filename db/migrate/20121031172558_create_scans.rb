class CreateScans < ActiveRecord::Migration
  def change
    create_table :scans do |t|
      t.text :title
      t.date :date
      t.boolean :finished
      t.boolean :imported

      t.timestamps
    end
  end
end
