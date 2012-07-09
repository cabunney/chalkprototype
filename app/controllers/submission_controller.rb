class SubmissionController < ApplicationController
	def QS
    if !signed_in?
      flash[:error] = "Please sign in to submit a question."
      redirect_to :signin
    else
      @categories = Category.find(:all, :order =>'id DESC');
		  @question = Question.new   
      @tags = []
	  end
	end
	
	def submitQ
	  @question = Question.new    
	  @tags_string = params[:question][:tags]
	  @tags = @tags_string.split(",")
	  @new_tags = []
		params[:question][:tags] = @new_tags
		if @question.update_attributes(params[:question]) then
		  @tags.each do |t|
  	    t = t.strip
  	    @old_tag = Tag.find_by_name(t)
  	    if @old_tag
  	      @new_tags << @old_tag
  	    else
  	      @tag = Tag.new
  		    @tag.user_id = current_user.id
          @tag.name = t
          @tag.save
          @new_tags << @tag;
        end
      end
      @question.tags = @new_tags
      @tags = []
		     flash[:success] = "Successfully posted your question!"
    		 redirect_to(:controller => :message_board, :action => :show)
  		else
   			 render(:action => :QS)
  		end

	end
	
	def post_push
    if !signed_in?
      flash[:error] = "Please log in before pushing."
      redirect_to root_path
    else
      @item = Question.find_by_id(params[:id])
      current_user.push_for(@item)
      @progress = @item.pushes_for.to_f/User.find(:all).count.to_f * 100
      respond_to do |format|
          format.js { render :content_type => 'text/javascript', :action => "post_push", :layout => false }
      end
    end
  end
  

  def remove_tag
     @tag = Tag.find_by_id(params[:id])
     if @tag
       @tag.destroy
       respond_to do |format|
        format.js { render :content_type => 'text/javascript', :action => "remove_tag", :layout => false }
      end
    end
  end
  
	def AS
	  if !signed_in?
      flash[:error] = "Please sign in to submit a question."
      redirect_to :signin
     else
        @categories = Category.find(:all, :order =>'id DESC');
  		  @answer = Answer.new   
  		  @question = Question.new
  	  end
	end		
  
	def submitA
		@answer = Answer.new
		@question = Question.new
		@question[:category_id] = params[:answer][:category_id]
  	
  	if @question.update_attributes(params[:question]) then
  	  @answer.question_id = @question.id
		  if @answer.update_attributes(params[:answer]) then
            flash[:success] = "Successfully posted your idea!"
    		    redirect_to(:controller => :message_board, :action => :show)
    		else
    		  @question.delete
    		  render(:action => :AS)	  
  		  end
  		else
   			 render(:action => :AS)
  		end
	end
	
	def editQ
	    if !signed_in?
        flash[:error] = "Please sign in to edit a question."
        redirect_to :signin
       else
         @question = Question.find(params[:id])
         if current_user.id!=@question.user_id
            flash[:error] = "You can only edit a question you submitted."
            redirect_to :controller => :message_board, :action => :show
         end
         @tags = @question.tags
         if !@tags
           @tags = []
         end
       end
  end
  
  def editQDetail 
   	if !signed_in?
        flash[:error] = "Please sign in to edit a question."
        redirect_to :signin
       else
         @question = Question.find(params[:id])
         if current_user.id!=@question.user_id
            flash[:error] = "You can only edit a question you submitted."
            redirect_to :controller => :message_board, :action => :details, :id => @question.id
         end
       end
       
    end
  
	 
	 def editA
 	    if !signed_in?
         flash[:error] = "Please sign in to edit an answer."
         redirect_to :signin
        else
          @answer = Answer.find(params[:id])
          if current_user.id!=@answer.user_id
             flash[:error] = "You can only edit an answer you submitted."
             redirect_to :controller => :message_board, :action => :show
          end
        end
   end
   
   def updateQ
     @question = Question.find(params[:id])
     @tags_string = params[:question][:tags]
   	 @tags = @tags_string.split(",")  
     @new_tags = []
     
   	 params[:question][:tags] = @new_tags
     if @question.update_attributes(params[:question])
        @tags.each do |t|
     	    t = t.strip
     	    @old_tag = Tag.find_by_name(t)
     	    if @old_tag
     	      @new_tags << @old_tag
     	    else
     	      @tag = Tag.new
     		    @tag.user_id = current_user.id
             @tag.name = t
             @tag.save
             @new_tags << @tag;
           end
         end
         @question.tags = @new_tags
       flash[:success] = "Updated your question!" 
       redirect_to :controller => :message_board, :action => :show
     
     else
       render :action => :editQS
     end
   end
   
    def updateQDetail
     @question = Question.find(params[:id])
     if @question.update_attributes(params[:question])
       flash[:success] = "Updated your question!" 
       redirect_to :controller => :message_board, :action => :details, :id => @question.id
     else
       render :action => :editQS
     end
   end
   
   def updateA
      @answer = Answer.find(params[:id])
      if @answer.update_attributes(params[:answer])
        flash[:success] = "Updated your answer!" 
        redirect_to :controller => :message_board, :action => :details, :id => @answer.question().id
      else
        render :action => :editAS
      end
    end
end