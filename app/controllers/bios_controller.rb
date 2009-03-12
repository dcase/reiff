class BiosController < ApplicationController
  before_filter :permission, :except => :show
  
  # GET /bios
  # GET /bios.xml
  def index
    @bios = Bio.find(:all, :order => :position)
    @bio = @bios.first

    respond_to do |format|
      format.html { render :template => 'bios/show' }
      format.xml  { render :xml => @bios }
    end
  end

  # GET /bios/1
  # GET /bios/1.xml
  def show
    @bios = Bio.find(:all, :order => :position)
    @bio = Bio.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @bio }
    end
  end

  # GET /bios/new
  # GET /bios/new.xml
  def new
    @bio = Bio.new

    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.xml  { render :xml => @bio }
    end
  end

  # GET /bios/1/edit
  def edit
    @bio = Bio.find(params[:id])
  end

  # POST /bios
  # POST /bios.xml
  def create
    @bio = Bio.new(params[:bio])

    respond_to do |format|
      if @bio.save
        flash[:notice] = 'Bio was successfully created.'
        format.html { redirect_to(@bio) }
        format.js do
          @bios = Bio.find(:all, :order => :position)
          responds_to_parent do
             render :js => "$('#page_sections_container').html('" +  @template.escape_javascript(render_to_string( :partial => "bio" )) + "');
             $('#sidebar').html('" +  @template.escape_javascript(render_to_string( :partial => "menu" )) + "');
             $('#modal-content').html("");
             $('#modal').jqmHide();"
          end
        end
        format.xml  { render :xml => @bio, :status => :created, :location => @bio }
      else
        format.html { render :action => "new" }
        format.js do
          responds_to_parent do 
            render :js => "$('#modal-content').html('" +  @template.escape_javascript(render_to_string(:action => "new", :layout => false)) + "')"
          end
        end
        format.xml  { render :xml => @bio.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bios/1
  # PUT /bios/1.xml
  def update
    @bio = Bio.find(params[:id])

    respond_to do |format|
      if @bio.update_attributes(params[:bio])
        flash[:notice] = 'Bio was successfully updated.'
        format.html { redirect_to(@bio) }
        format.js do
          @bios = Bio.find(:all, :order => :position)
          responds_to_parent do
             render :js => "$('#page_sections_container').html('" +  @template.escape_javascript(render_to_string( :partial => "bio" )) + "');
             $('#sidebar').html('" +  @template.escape_javascript(render_to_string( :partial => "menu" )) + "');
             $('#modal-content').html("");
             $('#modal').jqmHide();"
          end
        end
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.js do
          responds_to_parent do 
            render :js => "$('#modal-content').html('" +  @template.escape_javascript(render_to_string(:action => "edit", :layout => false)) + "')"
          end
        end
        format.xml  { render :xml => @bio.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bios/1
  # DELETE /bios/1.xml
  def destroy
    @bio = Bio.find(params[:id])
    @bio.destroy

    respond_to do |format|
      format.html { redirect_to bios_url }
      format.xml  { head :ok }
    end
  end
  
  def order
     params[:bio].each_with_index do |id, position|
       Bio.update(id, {:position => position+1})
     end
     render :text => params.inspect
   end

   def inspect_params
    render :text => params.inspect
   end
end
