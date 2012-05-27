# An example controller for "pushes" that are nested resources under users. See examples/routes.rb

class PushesController < ApplicationController

  # First, figure out our nested scope. User or Pushable? 
  before_filter :find_pushes_for_my_scope, :only => [:index]
     
  before_filter :login_required, :only => [:new, :edit, :destroy, :create, :update]
  before_filter :must_own_push,  :only => [:edit, :destroy, :update]
  before_filter :not_allowed,    :only => [:edit, :update, :new]

  # GET /users/:user_id/pushes/
  # GET /users/:user_id/pushes.xml
  # GET /users/:user_id/pushables/:pushable_id/pushes/
  # GET /users/:user_id/pushables/:pushable_id/pushes.xml
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pushes }
    end
  end

  # GET /users/:user_id/pushes/1
  # GET /users/:user_id/pushes/1.xml
  # GET /users/:user_id/pushables/:pushable_id/pushes/1
  # GET /users/:user_id/pushables/:pushable_id/1.xml
  def show
    @pushable = Push.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @push }
    end
  end


  # POST /users/:user_id/pushables/:pushable_id/pushes
  # POST /users/:user_id/pushables/:pushable_id/pushes.xml
  def create
    @pushable = Pushable.find(params[:quote_id])
    
    respond_to do |format|
      if current_user.push(@pushable, params[:push])
        format.rjs  { render :action => "create", :push => @push }
        format.html { redirect_to([@pushable.user, @pushable]) }
        format.xml  { render :xml => @pushable, :status => :created, :location => @pushable }
      else
        format.rjs  { render :action => "error" }
        format.html { render :action => "new" }
        format.xml  { render :xml => @push.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/:id/pushes/1
  # PUT /users/:id/pushes/1.xml
  def update
    # Not generally used
  end
  
  # DELETE /users/:id/pushes/1
  # DELETE /users/:id/pushes/1.xml
  def destroy
    @push = Push.find(params[:id])
    @push.destroy

    respond_to do |format|
      format.html { redirect_to(user_pushes_url) }
      format.xml  { head :ok }
    end
  end

  private
  def find_pushes_for_my_scope
    if params[:pushable_id]
      @pushes = Push.for_pushable(Pushable.find(params[:pushable_id])).descending
    elsif params[:user_id]
      @pushes = Push.for_pusher(User.find(params[:user_id])).descending         
    else  
      @pushes = []
    end
  end

  def must_own_push
    @push ||= Push.find(params[:id])
    @push.user == current_user || ownership_violation
  end

  def ownership_violation
    respond_to do |format|
      flash[:notice] = 'You cannot edit or delete pushes that you do not own!'
      format.html do
        redirect_to user_path(current_user)
      end
    end
  end

end
