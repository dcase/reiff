class SeoProfile < ActiveRecord::Base
  has_many :pages, :dependent => :nullify
  has_many :bios, :dependent => :nullify
  
  validates_presence_of :name, :title, :description, :keywords, :heading
  
  
  def after_destroy
    if id == 1
      raise "Can't delete the default profile"
    end
  end
end
