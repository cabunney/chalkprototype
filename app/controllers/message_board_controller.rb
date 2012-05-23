class MessageBoardController < ApplicationController
  def show
    @questions = Question.find(:all)
    @answers = Answer.find(:all)
  end
  
  def question
    @question = Question.find(params[:id])
    @answers = Answer.find_by_question_id(params[:id])
  end
  
  def answer
    @answer = Answer.find(params[:id])
    @questions = Question.find_by_answer_id(params[:id])
  end
  
  def details
  	@question = Question.find_by_id(params[:id])
    @new_answer = Answer.new
  end
  

  def post_answer
  	  @question = Question.find_by_id(params[:id])
  	  @new_answer = Answer.new
  		if @new_answer.update_attributes(params[:answer]) then
      		flash.now[:success] = "Answer submitted!"
          redirect_to(:action => :details, :id => params[:id])
    	else
    		  flash.now[:error] = @new_answer.errors.full_messages
          render(:action => :details, :id => params[:id])
    	end
    	
  end
  
  def post_details
  	
  end
  
end