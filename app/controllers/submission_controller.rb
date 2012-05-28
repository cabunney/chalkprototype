class SubmissionController < ApplicationController
	def QS
    if !signed_in?
      flash[:error] = "Please sign in to submit a question."
      redirect_to :signin
    else
      @categories = Category.find(:all, :order =>'id DESC');
		  @question = Question.new   
	  end
	end
	
	def submitQ
		@question = Question.new
		 if @question.update_attributes(params[:question]) then
    		 redirect_to(:controller => :message_board, :action => :show)
  		else
   			 render(:action => :QS)
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
            flash[:success] = "Idea submitted!"
    		    redirect_to(:controller => :message_board, :action => :show)
    		else
    		  render(:action => :AS)	  
  		  end
  		else
   			 render(:action => :AS)
  		end
	end
	 
end