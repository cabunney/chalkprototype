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
  	@answers = @question.answers
  	@category = Category.find_by_id(@question.category_id); 
  	@user = User.find_by_id(@question.user_id);
    @new_answer = Answer.new
  end
  
  def post_answer
    	@answer = Answer.new
  		if @answer.update_attributes(params[:new_answer]) then
      		flash.now[:success] = "Answer submitted!"
    	else
    		  flash.now[:error] = @answer.errors.full_messages
    	end  
      render(:action => :details, :id => @answer.question_id)
      
  end
  
  
end