class PageSection < ActiveRecord::Base
  belongs_to :page
  belongs_to :content, :polymorphic => true
  acts_as_list :scope => :page
  
  validates_presence_of :title
  validates_numericality_of :scroll_height, :if => Proc.new { |e| !e.scroll_height.blank? }
  validates_numericality_of :scroll_width, :if => Proc.new { |e| !e.scroll_height.blank? }
end
