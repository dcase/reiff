class ArticleListItem < ActiveRecord::Base
  belongs_to :article_list
  acts_as_list :scope => :article_list
  has_many :articles, :order => :position, :dependent => :destroy
  after_update :save_articles
  
  validates_presence_of :output
  validates_presence_of :url, :if => Proc.new { |a| a.is_link? }, :message => "cannot be blank if this is a link"
  
  def article_attributes=(article_attributes)
    article_attributes.each do |attributes| 
      if attributes[:id].blank?
        articles.build(attributes)
      else
        article = articles.detect { |a| a.id == attributes[:id].to_i }
        article.attributes = attributes
      end  
    end
  end
  
  def save_articles
    articles.each do |a|
      a.save(false)
    end
  end
end
