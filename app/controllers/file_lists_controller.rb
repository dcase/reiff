class FileListsController < ApplicationController
  before_filter :permission
  # GET /file_lists
  # GET /file_lists.xml
  def index
    @file_lists = FileList.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @file_lists }
    end
  end

  # GET /file_lists/1
  # GET /file_lists/1.xml
  def show
    @file_list = FileList.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @file_list }
    end
  end

  # GET /file_lists/new
  # GET /file_lists/new.xml
  def new
    @page = Page.find(params[:page_id])
    @site_section = @page.site_section
    @file_list = FileList.new
    @page_section = @file_list.build_page_section
    
    @file_list.file_list_items.build

    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.xml  { render :xml => @file_list }
    end
  end

  # GET /file_lists/1/edit
  def edit
    @file_list = FileList.find(params[:id])
    @page_section = @file_list.page_section
    @page = @page_section.page
    @site_section = @page.site_section
    
    if @file_list.file_list_items.empty?
      @file_list.file_list_items.build
    end
  end

  # POST /file_lists
  # POST /file_lists.xml
  def create
    @file_list = FileList.new(params[:file_list])
    @page_section = @file_list.build_page_section(params[:page_section])
    @page = @page_section.page
    @site_section = @page.site_section


    respond_to do |format|
      if @file_list.save
        flash[:notice] = 'FileList was successfully created.'
        format.js do
          responds_to_parent do
             render :js => "$('#page_sections_container').append('" +  @template.escape_javascript(render_to_string( :partial => "page_sections/show", :object => @page_section )) + "');$('#modal-content').html("");$('#modal').jqmHide();"
          end
        end
        format.html { redirect_to site_section_page_url(@site_section, @page) }
        format.xml  { render :xml => @file_list, :status => :created, :location => @file_list }
      else
        format.html { render :action => "new" }
        format.js do
          responds_to_parent do 
            render :js => "$('#modal-content').html('" +  @template.escape_javascript(render_to_string(:action => "new")) + "')"
          end
        end
        format.xml  { render :xml => @file_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /file_lists/1
  # PUT /file_lists/1.xml
  def update
    @file_list = FileList.find(params[:id])
    @page_section = @file_list.page_section
    @page = @page_section.page
    @site_section = @page.site_section

    respond_to do |format|
      if @file_list.update_attributes(params[:file_list]) and @page_section.update_attributes(params[:page_section])
        flash[:notice] = 'FileList was successfully updated.'
        format.html { redirect_to site_section_page_url(@site_section, @page) }
        format.js do
          responds_to_parent do
            render :js => "$('#page_section_" + @page_section.id.to_s + "').replaceWith('" + @template.escape_javascript(render_to_string(:partial => "page_sections/show", :object => @page_section)) + "');$('#modal-content').html("");$('#modal').jqmHide();"
          end
        end
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.js do 
          responds_to_parent do 
            render :js => "$('#modal-content').html('" +  @template.escape_javascript(render_to_string(:action => "edit")) + "')"
          end
        end
        format.xml  { render :xml => @file_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /file_lists/1
  # DELETE /file_lists/1.xml
  def destroy
    @file_list = FileList.find(params[:id])
    @page_section = @file_list.page_section
    @file_list.destroy
    @page = @page_section.page
    @site_section = @page.site_section

    respond_to do |format|
      format.html { redirect_to site_section_page_url(@site_section, @page) }
      format.js { render :js => "$('#page_section_#{@page_section.id}').remove()" }
      format.xml  { head :ok }
    end
  end
end
