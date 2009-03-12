class Article < ActiveRecord::Base
  belongs_to :article_list_item
  acts_as_list :scope => :article_list_item
  
  has_attached_file :page, :styles => { :original => "900x>", :thumb => "100x100>" }
  
  validates_attachment_presence :page
end
