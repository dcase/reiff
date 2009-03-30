class UploadedFileList < AbstractList
  has_one :page_section, :as => :content, :dependent => :destroy
  has_many :file_list_items, :order => :position, :dependent => :destroy
  
  after_update :save_file_list_items
  
  def file_list_item_attributes=(file_list_item_attributes)
    file_list_item_attributes.each do |attributes|
      if attributes[:id].blank?
        file_list_items.build(attributes)
      else
        file_list_item = file_list_items.detect { |a| a.id == attributes[:id].to_i }
        file_list_item.attributes = attributes
      end
    end
  end
  
  def save_file_list_items
    file_list_items.each do |a|
      a.save(false)
    end
  end
end