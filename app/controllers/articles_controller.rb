class ArticlesController < ApplicationController
  before_filter :permission
  def destroy
    @article = Article.find(params[:id])
    @article_list_item = @article.article_list_item
    
    @article.destroy
    
    respond_to do |format|
      format.js { render :partial => 'article_list_items/article', :collection => @article_list_item.articles }
    end
  end

  def order
    params[:article].each_with_index do |id, position|
     Article.update(id, {:position => position+1})
    end
    render :text => params.inspect
  end
 
  def inspect_params
    render :text => params.inspect
  end

end