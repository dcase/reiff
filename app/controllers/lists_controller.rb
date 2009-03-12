class ListsController < ApplicationController
  before_filter :permission
  # GET /lists
  # GET /lists.xml
  def index
    @lists = List.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @lists }
    end
  end

  # GET /lists/1
  # GET /lists/1.xml
  def show
    @list = List.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @list }
    end
  end

  # GET /lists/new
  # GET /lists/new.xml
  def new
    @page = Page.find(params[:page_id])
    @site_section = @page.site_section
    @list = List.new
    @page_section = @list.build_page_section
    
    @list.list_items.build

    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.xml  { render :xml => @list }
    end
  end

  # GET /lists/1/edit
  def edit
    @list = List.find(params[:id])
    @page_section = @list.page_section
    @page = @page_section.page
    @site_section = @page.site_section
    
    if @list.list_items.empty?
      @list.list_items.build
    end
  end

  # POST /lists
  # POST /lists.xml
  def create
    @list = List.new(params[:list])
    @page_section = @list.build_page_section(params[:page_section])
    @page = @page_section.page
    @site_section = @page.site_section

    respond_to do |format|
      if @list.save
        flash[:notice] = 'List was successfully created.'
        format.js { render :partial => "page_sections/show", :object => @page_section }
        format.html { redirect_to site_section_page_url(@site_section, @page) }
        format.xml  { render :xml => @list, :status => :created, :location => @list }
      else
        format.html { render :action => "new" }
        format.js { render :action => "new" }
        format.xml  { render :xml => @list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /lists/1
  # PUT /lists/1.xml
  def update
    @list = List.find(params[:id])
    @page_section = @list.page_section
    @page = @page_section.page
    @site_section = @page.site_section

    respond_to do |format|
      if @list.update_attributes(params[:list]) and @page_section.update_attributes(params[:page_section])
        flash[:notice] = 'List was successfully updated.'
        format.html { redirect_to site_section_page_url(@site_section, @page) }
        format.js { render :partial => "page_sections/show", :object => @page_section }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.js { render :action => "edit" }
        format.xml  { render :xml => @list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.xml
  def destroy
    @list = List.find(params[:id])
    @page_section = @list.page_section
    @list.destroy
    @page = @page_section.page
    @site_section = @page.site_section

    respond_to do |format|
      format.html { redirect_to site_section_page_url(@site_section, @page) }
      format.js { render :js => "$('#page_section_#{@page_section.id}').remove()" }
      format.xml  { head :ok }
    end
  end
end
