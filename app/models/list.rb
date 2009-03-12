class List < AbstractList
  has_one :page_section, :as => :content, :dependent => :destroy
  has_many :list_items, :order => :position, :dependent => :destroy
  
  after_update :save_list_items
  
  validates_associated :page_section, :message => 'probably needs a title or something'
  
  def list_item_attributes=(list_item_attributes)
    list_item_attributes.each do |attributes|
      if attributes[:id].blank?
        list_items.build(attributes)
      else
        list_item = list_items.detect { |a| a.id == attributes[:id].to_i }
        list_item.attributes = attributes
      end
    end
  end
  
  def save_list_items
    list_items.each do |a|
      a.save(false)
    end
  end
end
