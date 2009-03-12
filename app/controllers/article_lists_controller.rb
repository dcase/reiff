class ArticleListsController < ApplicationController
  before_filter :permission
  
  # GET /article_lists
  # GET /article_lists.xml
  def index
    @article_lists = ArticleList.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @article_lists }
    end
  end

  # GET /article_lists/1
  # GET /article_lists/1.xml
  def show
    @article_list = ArticleList.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @article_list }
    end
  end

  # GET /article_lists/new
  # GET /article_lists/new.xml
  def new
    @page = Page.find(params[:page_id])
    @site_section = @page.site_section
    @article_list = ArticleList.new
    @page_section = @article_list.build_page_section

    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.xml  { render :xml => @article_list }
    end
  end

  # GET /article_lists/1/edit
  def edit
    @article_list = ArticleList.find(params[:id])
    @page_section = @article_list.page_section
    @page = @page_section.page
    @site_section = @page.site_section
    
  end

  # POST /article_lists
  # POST /article_lists.xml
  def create
    @article_list = ArticleList.new(params[:article_list])
    @page_section = @article_list.build_page_section(params[:page_section])
    
    @page = @page_section.page
    @site_section = @page.site_section

    respond_to do |format|
      if @article_list.save
        flash[:notice] = 'ArticleList was successfully created.'
        format.html { redirect_to site_section_page_url(@site_section, @page) }
        format.js { render :partial => "page_sections/show" }
        format.xml  { render :xml => @article_list, :status => :created, :location => @article_list }
      else
        @page_section.destroy
        format.html { render :action => "new" }
        format.js { render :action => "new" }
        format.xml  { render :xml => @article_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /article_lists/1
  # PUT /article_lists/1.xml
  def update
    @article_list = ArticleList.find(params[:id])
    @page_section =  @article_list.page_section
    
    @page = @page_section.page
    @site_section = @page.site_section

    respond_to do |format|
      if @article_list.update_attributes(params[:article_list]) and @page_section.update_attributes(params[:page_section])
        flash[:notice] = 'ArticleList was successfully updated.'
        format.html { redirect_to site_section_page_url(@site_section, @page) }
        format.js { render :partial => "page_sections/show" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.js { render :action => "edit" }
        format.xml  { render :xml => @article_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /article_lists/1
  # DELETE /article_lists/1.xml
  def destroy
    @article_list = ArticleList.find(params[:id])
    @page_section = @article_list.page_section
    @article_list.destroy
    
    @page = @page_section.page
    @site_section = @page.site_section


    respond_to do |format|
      format.html { redirect_to site_section_page_url(@site_section, @page) }
      format.js { render :js => "$('#page_section_" + @page_section.id.to_s + "').remove()" }
      format.xml  { head :ok }
    end
  end
end
