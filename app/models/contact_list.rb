class ContactList < AbstractList
  has_one :page_section, :as => :content, :dependent => :destroy
  has_many :contact_list_items, :order => :position, :dependent => :destroy
  
  after_update :save_contact_list_items
  
  validates_associated :page_section, :message => 'probably needs a title or something'
  
  def contact_list_item_attributes=(contact_list_item_attributes)
    contact_list_item_attributes.each do |attributes|
      if attributes[:id].blank?
        contact_list_items.build(attributes)
      else
        contact_list_item = contact_list_items.detect { |a| a.id == attributes[:id].to_i }
        contact_list_item.attributes = attributes
      end
    end
  end
  
  def save_contact_list_items
    contact_list_items.each do |a|
      a.save(false)
    end
  end
end