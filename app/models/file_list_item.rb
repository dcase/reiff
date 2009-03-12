class FileListItem < ActiveRecord::Base
  belongs_to :file_list
  
  has_attached_file :file
  
  acts_as_list :scope => :file_list
  
  validates_presence_of :description
  validates_attachment_presence :file
end
