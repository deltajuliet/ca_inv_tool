class InventoryFile < ActiveRecord::Base
  attr_accessible :filename



  def self.parse_inventory_file(upload)
    name =  upload['datafile'].original_filename
    directory = "public/data"
    # create the file path
    path = File.join(directory, name)
    # write the file
    File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
  end

  def self.add_items_to_database
    ActiveRecord::Base.connection.execute("TRUNCATE inventory_items")
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE inventory_items_id_seq RESTART WITH 1")
  end
end
