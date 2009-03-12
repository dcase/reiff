class ContactListItemsController < ApplicationController
  before_filter :permission
  
  # GET /contact_list_items
  # GET /contact_list_items.xml
  def index
    @contact_list = ContactList.find(params[:contact_list_id])
    @contact_list_items = @contact_list.contact_list_items.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contact_list_items }
    end
  end

  # GET /contact_list_items/1
  # GET /contact_list_items/1.xml
  def show
    @contact_list = ContactList.find(params[:contact_list_id])
    @contact_list_item = @contact_list.contact_list_items.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contact_list_item }
    end
  end

  # GET /contact_list_items/new
  # GET /contact_list_items/new.xml
  def new
    @contact_list = ContactList.find(params[:contact_list_id])
    @contact_list_item = @contact_list.contact_list_items.build
    
    @page_section = @contact_list.page_section
    @page = @page_section.page
    @site_section = @page.site_section

    respond_to do |format|
      format.js
      format.html # new.html.erb
      format.xml  { render :xml => @contact_list_item }
    end
  end

  # GET /contact_list_items/1/edit
  def edit
    @contact_list = ContactList.find(params[:contact_list_id])
    @contact_list_item = @contact_list.contact_list_items.find(params[:id])
    
    @page_section = @contact_list.page_section
    @page = @page_section.page
    @site_section = @page.site_section
  end

  # POST /contact_list_items
  # POST /contact_list_items.xml
  def create
    @contact_list = ContactList.find(params[:contact_list_id])
    @contact_list_item = @contact_list.contact_list_items.build(params[:contact_list_item])
    
    @page_section = @contact_list.page_section
    @page = @page_section.page
    @site_section = @page.site_section

    respond_to do |format|
      if @contact_list_item.save
        flash[:notice] = 'ContactListItem was successfully created.'
        format.html { redirect_to  site_section_page_url(@site_section, @page) }
        format.js { render :partial => "page_sections/show" }
        format.xml  { render :xml => @contact_list_item, :status => :created, :location => @contact_list_item }
      else
        format.html { render :action => "new" }
        format.js { render :action => "new" }
        format.xml  { render :xml => @contact_list_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /contact_list_items/1
  # PUT /contact_list_items/1.xml
  def update
    @contact_list = ContactList.find(params[:contact_list_id])
    @contact_list_item = @contact_list.contact_list_items.find(params[:id])
    
    @page_section = @contact_list.page_section
    @page = @page_section.page
    @site_section = @page.site_section

    respond_to do |format|
      if @contact_list_item.update_attributes(params[:contact_list_item])
        flash[:notice] = 'ContactListItem was successfully updated.'
        format.html { redirect_to site_section_page_url(@site_section, @page) }
        format.js { render :partial => "page_sections/show" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.js { render :action => "edit" }
        format.xml  { render :xml => @contact_list_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contact_list_items/1
  # DELETE /contact_list_items/1.xml
  def destroy
    @contact_list = ContactList.find(params[:contact_list_id])
    @contact_list_item = @contact_list.contact_list_items.find(params[:id])
    
    contact_list_item_id = @contact_list_item.id
    
    @page_section = @contact_list.page_section
    @page = @page_section.page
    @site_section = @page.site_section
    
    @contact_list_item.destroy

    respond_to do |format|
      format.html { redirect_to site_section_page_url(@site_section, @page) }
      format.js { render :js => "$('#contact_list_item_#{contact_list_item_id}').remove()" }
      format.xml  { head :ok }
    end
  end
  
  def order
    params[:contact_list_item].each_with_index do |id, position|
     ContactListItem.update(id, {:position => position+1})
    end
    render :text => params.inspect
  end
 
  def inspect_params
    render :text => params.inspect
  end
end
