class PagesController < ApplicationController
  before_filter :permission, :except => :show
  
  # GET /pages
  # GET /pages.xml
  def index
    @site_section = SiteSection.find(params[:site_section_id])
    @pages = @site_section.pages
    
    @site_section_root = @site_section.set_root

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pages }
    end
  end

  # GET /pages/1
  # GET /pages/1.xml
  def show
    @site_section = SiteSection.find(params[:site_section_id])
    @page = @site_section.pages.find(params[:id])
    
    @site_section_root = @site_section.set_root

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # GET /pages/new
  # GET /pages/new.xml
  def new
    @site_section = SiteSection.find(params[:site_section_id])
    @page = @site_section.pages.build
    
    @site_section_root = @site_section.set_root
    
    session[:back_url] = request.referer || site_section_url(@site_section)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # GET /pages/1/edit
  def edit
    @site_section = SiteSection.find(params[:site_section_id])
    @page = @site_section.pages.find(params[:id])
    
    @site_section_root = @site_section.set_root
  end

  # POST /pages
  # POST /pages.xml
  def create
    @site_section = SiteSection.find(params[:site_section_id])
    @page = @site_section.pages.build(params[:page])
    
    @site_section_root = @site_section.set_root

    respond_to do |format|
      if @page.save
        flash[:notice] = 'Page was successfully created.'
        format.html { redirect_to site_section_page_url(@site_section, @page) }
        format.xml  { render :xml => @page, :status => :created, :location => @page }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.xml
  def update
    @site_section = SiteSection.find(params[:site_section_id])
    @page = @site_section.pages.find(params[:id])
    
    @site_section_root = @site_section.set_root

    respond_to do |format|
      if @page.update_attributes(params[:page])
        flash[:notice] = 'Page was successfully updated.'
        format.html { redirect_to site_section_page_url(@site_section,@page) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.xml
  def destroy
    @site_section = SiteSection.find(params[:site_section_id])
    @page = @site_section.pages.find(params[:id])
    @page.destroy
    
    @site_section_root = @site_section.set_root

    respond_to do |format|
      format.html { redirect_to site_section_url(@page.site_section_id) }
      format.xml  { head :ok }
    end
  end
  
  def order
     params[:page].each_with_index do |id, position|
       Page.update(id, {:position => position+1})
     end
     render :text => params.inspect
   end

   def inspect_params
    render :text => params.inspect
   end
   
end
