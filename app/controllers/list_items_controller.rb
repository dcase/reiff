class ListItemsController < ApplicationController
  before_filter :permission
  
  # GET /list_items
  # GET /list_items.xml
  def index
    @list = List.find(params[:list_id])
    @list_items = @list.list_items.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @list_items }
    end
  end

  # GET /list_items/1
  # GET /list_items/1.xml
  def show
    @list = List.find(params[:list_id])
    @list_item = @list.list_items.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @list_item }
    end
  end

  # GET /list_items/new
  # GET /list_items/new.xml
  def new
    @list = List.find(params[:list_id])
    @list_item = @list.list_items.build
    
    @page_section = @list.page_section
    @page = @page_section.page
    @site_section = @page.site_section

    respond_to do |format|
      format.js
      format.html # new.html.erb
      format.xml  { render :xml => @list_item }
    end
  end

  # GET /list_items/1/edit
  def edit
    @list = List.find(params[:list_id])
    @list_item = @list.list_items.find(params[:id])
    
    @page_section = @list.page_section
    @page = @page_section.page
    @site_section = @page.site_section
  end

  # POST /list_items
  # POST /list_items.xml
  def create
    @list = List.find(params[:list_id])
    @list_item = @list.list_items.build(params[:list_item])
    
    @page_section = @list.page_section
    @page = @page_section.page
    @site_section = @page.site_section

    respond_to do |format|
      if @list_item.save
        flash[:notice] = 'ListItem was successfully created.'
        format.html { redirect_to  site_section_page_url(@site_section, @page) }
        format.js { render :partial => "page_sections/show" }
        format.xml  { render :xml => @list_item, :status => :created, :location => @list_item }
      else
        format.html { render :action => "new" }
        format.js { render :action => "new" }
        format.xml  { render :xml => @list_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /list_items/1
  # PUT /list_items/1.xml
  def update
    @list = List.find(params[:list_id])
    @list_item = @list.list_items.find(params[:id])
    
    @page_section = @list.page_section
    @page = @page_section.page
    @site_section = @page.site_section

    respond_to do |format|
      if @list_item.update_attributes(params[:list_item])
        flash[:notice] = 'ListItem was successfully updated.'
        format.html { redirect_to site_section_page_url(@site_section, @page) }
        format.js { render :partial => "page_sections/show" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.js { render :action => "edit" }
        format.xml  { render :xml => @list_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /list_items/1
  # DELETE /list_items/1.xml
  def destroy
    @list = List.find(params[:list_id])
    @list_item = @list.list_items.find(params[:id])
    
    list_item_id = @list_item.id
    
    @page_section = @list.page_section
    @page = @page_section.page
    @site_section = @page.site_section
    
    @list_item.destroy

    respond_to do |format|
      format.html { redirect_to site_section_page_url(@site_section, @page) }
      format.js { render :js => "$('#list_item_#{list_item_id}').remove()" }
      format.xml  { head :ok }
    end
  end
  
  def order
    params[:list_item].each_with_index do |id, position|
     ListItem.update(id, {:position => position+1})
    end
    render :text => params.inspect
  end
 
  def inspect_params
    render :text => params.inspect
  end
end
