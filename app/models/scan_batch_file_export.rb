class ScanBatchFileExport < ActiveRecord::Base
  attr_accessible :export_name, :scan_id

  def to_csv(scan_id)

    scan_data = ScanItem.find_all_by_scan_id(scan_id)
    CSV.generate do |csv|
      csv << column_names
      scan_data.each do |item|
        if item.scan_id == scan_id
          csv << product.attributes.values_at(*column_names)
        end
      end
    end
  end
end
