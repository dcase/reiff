class ArticleList < AbstractList
  has_one :page_section, :as => :content, :dependent => :destroy
  has_many :article_list_items, :order => :position, :dependent => :destroy
end