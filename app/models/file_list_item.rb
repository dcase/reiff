class FileListItem < ActiveRecord::Base
  belongs_to :uploaded_file_list
  
  has_attached_file :file
  
  acts_as_list :scope => :uploaded_file_list
  
  validates_presence_of :description
  validates_attachment_presence :file
end
