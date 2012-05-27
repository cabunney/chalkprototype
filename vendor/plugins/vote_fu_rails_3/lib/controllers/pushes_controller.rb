class PushesController < ApplicationController
  # First, figure out our nested scope. User or push?
#  before_filter :find_my_scope
  
#  before_filter :find_user
    
#  before_filter :login_required, :only => [:new, :edit, :destroy, :create, :update]
#  before_filter :must_own_push,  :only => [:edit, :destroy, :update]


  # GET /pushes/
  # GET /pushes.xml
  def index
    @pushes = Push.descending

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pushes }
    end
  end

    # GET /pushes/1
    # GET /pushes/1.xml
    def show
      @push = Push.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @push }
      end
    end

    # GET /pushes/new
    # GET /pushes/new.xml
    def new
      @push = Push.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @push }
      end
    end

    # GET /pushes/1/edit
    def edit
      @push ||= Push.find(params[:id])
    end

    # POST /pushes
    # POST /pushes.xml
    def create
      @push = Push.new(params[:push])
      @push.user = current_user

      respond_to do |format|
        if @push.save
          flash[:notice] = 'Push was successfully saved.'
          format.html { redirect_to([@user, @push]) }
          format.xml  { render :xml => @push, :status => :created, :location => @push }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @push.errors, :status => :unprocessable_entity }
        end
      end
    end

    # PUT /pushes/1
    # PUT /pushes/1.xml
    def update
      @push = Push.find(params[:id])

      respond_to do |format|
        if @push.update_attributes(params[:push])
          flash[:notice] = 'Push was successfully updated.'
          format.html { redirect_to([@user, @push]) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @push.errors, :status => :unprocessable_entity }
        end
      end
    end

    # DELETE /pushes/1
    # DELETE /pushes/1.xml
    def destroy
      @push = Push.find(params[:id])
      @push.destroy

      respond_to do |format|
        format.html { redirect_to(user_pushes_url) }
        format.xml  { head :ok }
      end
    end

end
