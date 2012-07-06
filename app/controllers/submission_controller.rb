class SubmissionController < ApplicationController
	def QS
    if !signed_in?
      flash[:error] = "Please sign in to submit a question."
      redirect_to :signin
    else
      @categories = Category.find(:all, :order =>'id DESC');
		  @question = Question.new   
  	  @tags = Tag.find_by_question_id(@question.id)

	  end
	  @tags = Tag.all
	end
	
	def submitQ
		@question = Question.new
		 if @question.update_attributes(params[:question]) then
		     @tag = Tag.find_by_id(params[:id])
		     @tag.question_id = @question.id
		     @tag.save
		     flash[:success] = "Successfully posted your question!"
    		 redirect_to(:controller => :message_board, :action => :show)
  		else
   			 render(:action => :QS)
  		end
	end
	
	def tagItem
      @tag = Tag.new
      #if params[:is_question]
      #  @tag.question_id = params[:id]
      #else
      #  @tag.answer_id = params[:id]
      #end
      @tag.user_id = params[:user_id]
      @tag.name = params[:name]
      @tag.save

      if params[:is_question]      
        @tags = Tag.find_by_question_id(params[:id])
      else
        @tags = Tag.find_by_answer_id(params[:id])
      end
      @tags = []
      @tags << @tag
      render :partial =>"tag", :layout => false
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
     if @question.update_attributes(params[:question])
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