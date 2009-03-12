class ContactListsController < ApplicationController
  before_filter :permission
  # GET /contact_lists
  # GET /contact_lists.xml
  def index
    @contact_lists = ContactList.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contact_lists }
    end
  end

  # GET /contact_lists/1
  # GET /contact_lists/1.xml
  def show
    @contact_list = ContactList.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contact_list }
    end
  end

  # GET /contact_lists/new
  # GET /contact_lists/new.xml
  def new
    @page = Page.find(params[:page_id])
    @site_section = @page.site_section
    @contact_list = ContactList.new
    @page_section = @contact_list.build_page_section
    
    @contact_list.contact_list_items.build

    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.xml  { render :xml => @contact_list }
    end
  end

  # GET /contact_lists/1/edit
  def edit
    @contact_list = ContactList.find(params[:id])
    @page_section = @contact_list.page_section
    @page = @page_section.page
    @site_section = @page.site_section
    
    if @contact_list.contact_list_items.empty?
      @contact_list.contact_list_items.build
    end
  end

  # POST /contact_lists
  # POST /contact_lists.xml
  def create
    @contact_list = ContactList.new(params[:contact_list])
    @page_section = @contact_list.build_page_section(params[:page_section])
    @page = @page_section.page
    @site_section = @page.site_section

    respond_to do |format|
      if @contact_list.save
        flash[:notice] = 'ContactList was successfully created.'
        format.js { render :partial => "page_sections/show", :object => @page_section }
        format.html { redirect_to site_section_page_url(@site_section, @page) }
        format.xml  { render :xml => @contact_list, :status => :created, :location => @contact_list }
      else
        format.html { render :action => "new" }
        format.js { render :action => "new" }
        format.xml  { render :xml => @contact_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /contact_lists/1
  # PUT /contact_lists/1.xml
  def update
    @contact_list = ContactList.find(params[:id])
    @page_section = @contact_list.page_section
    @page = @page_section.page
    @site_section = @page.site_section

    respond_to do |format|
      if @contact_list.update_attributes(params[:contact_list]) and @page_section.update_attributes(params[:page_section])
        flash[:notice] = 'ContactList was successfully updated.'
        format.html { redirect_to site_section_page_url(@site_section, @page) }
        format.js { render :partial => "page_sections/show", :object => @page_section }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.js { render :action => "edit" }
        format.xml  { render :xml => @contact_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contact_lists/1
  # DELETE /contact_lists/1.xml
  def destroy
    @contact_list = ContactList.find(params[:id])
    @page_section = @contact_list.page_section
    @contact_list.destroy
    @page = @page_section.page
    @site_section = @page.site_section

    respond_to do |format|
      format.html { redirect_to site_section_page_url(@site_section, @page) }
      format.js { render :js => "$('#page_section_#{@page_section.id}').remove()" }
      format.xml  { head :ok }
    end
  end
end
