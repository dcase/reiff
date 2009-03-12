class CopyTextsController < ApplicationController
  before_filter :permission
  
  # GET /copy_texts
  # GET /copy_texts.xml
  def index
    @copy_texts = CopyText.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @copy_texts }
    end
  end

  # GET /copy_texts/1
  # GET /copy_texts/1.xml
  def show
    @copy_text = CopyText.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @copy_text }
    end
  end

  # GET /copy_texts/new
  # GET /copy_texts/new.xml
  def new
    @page = Page.find(params[:page_id])
    @site_section = @page.site_section
    @copy_text = CopyText.new
    @page_section = @copy_text.build_page_section

    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.xml  { render :xml => @copy_text }
    end
  end

  # GET /copy_texts/1/edit
  def edit
    @copy_text = CopyText.find(params[:id])
    @page_section = @copy_text.page_section
    @page = @page_section.page
    @site_section = @page.site_section
  end

  # POST /copy_texts
  # POST /copy_texts.xml
  def create
    @copy_text = CopyText.new(params[:copy_text])
    @page_section = @copy_text.build_page_section(params[:page_section])
    @page = @page_section.page
    @site_section = @page.site_section
    
    respond_to do |format|
      if @copy_text.save
        flash[:notice] = 'CopyText was successfully created.'
        format.html { redirect_to site_section_page_url(@site_section, @page) }
        format.js { render :partial => "page_sections/show", :object => @page_section }
        format.xml  { render :xml => @copy_text, :status => :created, :location => @copy_text }
      else
        format.html { render :action => "new" }
        format.js { render :action => "new" }
        format.xml  { render :xml => @copy_text.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /copy_texts/1
  # PUT /copy_texts/1.xml
  def update
    @copy_text = CopyText.find(params[:id])
    @page_section = @copy_text.page_section
    @page = @page_section.page
    @site_section = @page.site_section

    respond_to do |format|
      if @copy_text.update_attributes(params[:copy_text]) and @page_section.update_attributes(params[:page_section])
        flash[:notice] = 'CopyText was successfully updated.'
        format.js { render :partial => "page_sections/show", :object => @page_section }
        format.html { redirect_to site_section_page_url(@site_section, @page) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.js { render :action => "edit" }
        format.xml  { render :xml => @copy_text.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /copy_texts/1
  # DELETE /copy_texts/1.xml
  def destroy
    @copy_text = CopyText.find(params[:id])
    @page_section = @copy_text.page_section
    @copy_text.destroy
    @page = @page_section.page
    @site_section = @page.site_section

    respond_to do |format|
      format.html { redirect_to site_section_page_url(@site_section, @page) }
      format.js { render :js => "$('#page_section_#{@page_section.id}').remove()" }
      format.xml  { head :ok }
    end
  end
end
