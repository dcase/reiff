class PageSectionsController < ApplicationController
  # before_filter :permission
  # GET /page_sections
  # GET /page_sections.xml
  def index
    @page = Page.find(params[:page_id])
    @page_sections = @page.page_sections.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @page_sections }
    end
  end

  # GET /page_sections/1
  # GET /page_sections/1.xml
  def show
    @page = Page.find(params[:page_id])
    @page_section = @page.page_sections.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page_section }
    end
  end

  # GET /page_sections/new
  # GET /page_sections/new.xml
  def new
    @page = Page.find(params[:page_id])
    @page_section = @page.page_sections.build
    @site_section = @page.site_section

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @page_section }
    end
  end

  # GET /page_sections/1/edit
  def edit
    @page = Page.find(params[:page_id])
    @page_section = @page.page_sections.find(params[:id])
  end

  # POST /page_sections
  # POST /page_sections.xml
  def create
    @page = Page.find(params[:page_id])
    @page_section = @page.page_sections.build(params[:page_section])

    respond_to do |format|
      if @page_section.save
        flash[:notice] = 'PageSection was successfully created.'
        format.html { redirect_to(@page_section) }
        format.xml  { render :xml => @page_section, :status => :created, :location => @page_section }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @page_section.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /page_sections/1
  # PUT /page_sections/1.xml
  def update
    @page = Page.find(params[:page_id])
    @page_section = @page.page_sections.find(params[:id])

    respond_to do |format|
      if @page_section.update_attributes(params[:page_section])
        flash[:notice] = 'PageSection was successfully updated.'
        format.html { redirect_to(@page_section) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @page_section.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /page_sections/1
  # DELETE /page_sections/1.xml
  def destroy
    @page = Page.find(params[:page_id])
    @page_section = @page.page_sections.find(params[:id])
    @page_section.destroy

    respond_to do |format|
      format.html { redirect_to(page_sections_url) }
      format.xml  { head :ok }
    end
  end
  
  def order
     params[:page_section].each_with_index do |id, position|
       PageSection.update(id, {:position => position+1})
     end
     render :text => params.inspect
   end

   def inspect_params
    render :text => params.inspect
   end
end
