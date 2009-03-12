class Page < ActiveRecord::Base
  belongs_to :site_section
  has_many :page_sections, :order => :position
  acts_as_list :scope => :site_section
  belongs_to :seo_profile
  
  validates_presence_of :name
  
  def to_param
    "#{id}-#{name.downcase.strip.gsub(/\ /, '-').gsub(/[^\w\-]/, '').gsub(/[-]+/, '-')}"
  end
end
