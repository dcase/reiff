class SiteSection < ActiveRecord::Base
  has_many :pages, :order => :position, :dependent => :destroy
  acts_as_list :scope => :parent_id
  acts_as_tree :order => :position
  
  named_scope :roots, :conditions => { :parent_id => nil }
  
  validates_presence_of :name
  
  def to_param
    "#{id}-#{name.downcase.strip.gsub(/\ /, '-').gsub(/[^\w\-]/, '').gsub(/[-]+/, '-')}"
  end
  
  def set_root
    ancestors = self.ancestors
    unless ancestors.empty? 
      root = ancestors.last
    else
      root = self
    end
  end
  
  def find_first_page
    if self.pages.empty? && self.children.empty?
      return self, false
    elsif self.pages.empty? && !self.children.empty?
      return self.children.first.find_first_page
    elsif !self.pages.empty? && self.children.empty?
      return self, self.pages.first
    else
      return false
    end
  end
  
end
