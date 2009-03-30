class FileListItemsController < ApplicationController
  before_filter :permission
  
  # GET /file_list_items
  # GET /file_list_items.xml
  def index
    @file_list = UploadedFileList.find(params[:uploaded_file_list_id])
    @file_list_items = @file_list.file_list_items.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @file_list_items }
    end
  end

  # GET /file_list_items/1
  # GET /file_list_items/1.xml
  def show
    @file_list = UploadedFileList.find(params[:uploaded_file_list_id])
    @file_list_item = @file_list.file_list_items.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @file_list_item }
    end
  end

  # GET /file_list_items/new
  # GET /file_list_items/new.xml
  def new
    @file_list = UploadedFileList.find(params[:uploaded_file_list_id])
    @file_list_item = @file_list.file_list_items.build
    
    @page_section = @file_list.page_section
    @page = @page_section.page
    @site_section = @page.site_section

    respond_to do |format|
      format.js
      format.html # new.html.erb
      format.xml  { render :xml => @file_list_item }
    end
  end

  # GET /file_list_items/1/edit
  def edit
    @file_list = UploadedFileList.find(params[:uploaded_file_list_id])
    @file_list_item = @file_list.file_list_items.find(params[:id])
    
    @page_section = @file_list.page_section
    @page = @page_section.page
    @site_section = @page.site_section
  end

  # POST /file_list_items
  # POST /file_list_items.xml
  def create
    @file_list = UploadedFileList.find(params[:uploaded_file_list_id])
    @file_list_item = @file_list.file_list_items.build(params[:file_list_item])
    
    @page_section = @file_list.page_section
    @page = @page_section.page
    @site_section = @page.site_section

    respond_to do |format|
      if @file_list_item.save
        flash[:notice] = 'FileListItem was successfully created.'
        format.html { redirect_to  site_section_page_url(@site_section, @page) }
        format.js do
          responds_to_parent do
             render :js => "$('#page_section_" + @page_section.id.to_s + "').replaceWith('" + @template.escape_javascript(render_to_string(:partial => "page_sections/show")) + "');$('#modal-content').html("");$('#modal').jqmHide();"
          end
        end
        format.xml  { render :xml => @file_list_item, :status => :created, :location => @file_list_item }
      else
        format.html { render :action => "new" }
        format.js do
          responds_to_parent do 
            render :js => "$('#modal-content').html('" +  @template.escape_javascript(render_to_string(:action => "new")) + "')"
          end
        end
        format.xml  { render :xml => @file_list_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /file_list_items/1
  # PUT /file_list_items/1.xml
  def update
    @file_list = UploadedFileList.find(params[:uploaded_file_list_id])
    @file_list_item = @file_list.file_list_items.find(params[:id])
    
    @page_section = @file_list.page_section
    @page = @page_section.page
    @site_section = @page.site_section

    respond_to do |format|
      if @file_list_item.update_attributes(params[:file_list_item])
        flash[:notice] = 'FileListItem was successfully updated.'
        format.html { redirect_to site_section_page_url(@site_section, @page) }
        format.js do
          responds_to_parent do
             render :js => "$('#file_list_item_" + @file_list_item.id.to_s + "').replaceWith('" + @template.escape_javascript(render_to_string(:partial => "file_list_items/show", :locals => { :file_list_item => @file_list_item })) + "');$('#modal-content').html("");$('#modal').jqmHide();"
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
        format.xml  { render :xml => @file_list_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /file_list_items/1
  # DELETE /file_list_items/1.xml
  def destroy
    @file_list = UploadedFileList.find(params[:uploaded_file_list_id])
    @file_list_item = @file_list.file_list_items.find(params[:id])
    
    file_list_item_id = @file_list_item.id
    
    @page_section = @file_list.page_section
    @page = @page_section.page
    @site_section = @page.site_section
    
    @file_list_item.destroy

    respond_to do |format|
      format.html { redirect_to site_section_page_url(@site_section, @page) }
      format.js { render :js => "$('#page_section_" + @page_section.id.to_s + "').replaceWith('" + @template.escape_javascript(render_to_string(:partial => "page_sections/show")) + "');$('#modal-content').html("");$('#modal').jqmHide();" }
      format.xml  { head :ok }
    end
  end
  
  def order
    params[:file_list_item].each_with_index do |id, position|
     FileListItem.update(id, {:position => position+1})
    end
    render :text => params.inspect
  end
 
  def inspect_params
    render :text => params.inspect
  end
end
