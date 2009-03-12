class RawHtmlsController < ApplicationController
  before_filter :permission

   # GET /raw_htmls
   # GET /raw_htmls.xml
   def index
     @raw_htmls = RawHtml.find(:all)

     respond_to do |format|
       format.html # index.html.erb
       format.xml  { render :xml => @raw_htmls }
     end
   end

   # GET /raw_htmls/1
   # GET /raw_htmls/1.xml
   def show
     @raw_html = RawHtml.find(params[:id])

     respond_to do |format|
       format.html # show.html.erb
       format.xml  { render :xml => @raw_html }
     end
   end

   # GET /raw_htmls/new
   # GET /raw_htmls/new.xml
   def new
     @page = Page.find(params[:page_id])
     @site_section = @page.site_section
     @raw_html = RawHtml.new
     @page_section = @raw_html.build_page_section

     respond_to do |format|
       format.html # new.html.erb
       format.js
       format.xml  { render :xml => @raw_html }
     end
   end

   # GET /raw_htmls/1/edit
   def edit
     @raw_html = RawHtml.find(params[:id])
     @page_section = @raw_html.page_section
     @page = @page_section.page
     @site_section = @page.site_section
   end

   # POST /raw_htmls
   # POST /raw_htmls.xml
   def create
     @raw_html = RawHtml.new(params[:raw_html])
     @page_section = @raw_html.build_page_section(params[:page_section])
     @page = @page_section.page
     @site_section = @page.site_section

     respond_to do |format|
       if @raw_html.save
         flash[:notice] = 'RawHtml was successfully created.'
         format.html { redirect_to site_section_page_url(@site_section, @page) }
         format.js { render :partial => "page_sections/show", :object => @page_section }
         format.xml  { render :xml => @raw_html, :status => :created, :location => @raw_html }
       else
         format.html { render :action => "new" }
         format.js { render :action => "new" }
         format.xml  { render :xml => @raw_html.errors, :status => :unprocessable_entity }
       end
     end
   end

   # PUT /raw_htmls/1
   # PUT /raw_htmls/1.xml
   def update
     @raw_html = RawHtml.find(params[:id])
     @page_section = @raw_html.page_section
     @page = @page_section.page
     @site_section = @page.site_section

     respond_to do |format|
       if @raw_html.update_attributes(params[:raw_html]) and @page_section.update_attributes(params[:page_section])
         flash[:notice] = 'RawHtml was successfully updated.'
         format.html { redirect_to site_section_page_url(@site_section, @page) }
         format.js { render :partial => "page_sections/show", :object => @page_section }
         format.xml  { head :ok }
       else
         format.html { render :action => "edit" }
         format.js { render :action => "edit" }
         format.xml  { render :xml => @raw_html.errors, :status => :unprocessable_entity }
       end
     end
   end

   # DELETE /raw_htmls/1
   # DELETE /raw_htmls/1.xml
   def destroy
     @raw_html = RawHtml.find(params[:id])
     @page_section = @raw_html.page_section
     @raw_html.destroy
     
     @page = @page_section.page
     @site_section = @page.site_section

     respond_to do |format|
       format.html { redirect_to site_section_page_url(@site_section, @page) }
       format.js { render :js => "$('#page_section_#{@page_section.id}').remove()" }
       format.xml  { head :ok }
     end
   end
end
