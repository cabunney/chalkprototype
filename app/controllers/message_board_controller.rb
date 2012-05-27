class MessageBoardController < ApplicationController
  def show
    @questions = Question.find(:all)
    @answers = Answer.find(:all)
  end
  
  # def question
  #     @question = Question.find(params[:id])
  #     current_user.vote_for(@question)
  #     @question_votes = Vote.for_voteable(@question)
  #     @answers = Answer.find_by_question_id(params[:id])
  #     @answers_votes = Vote.for_voteable(@answers).descending
  #   end
  #   
  #   def answer
  #     @answer = Answer.find(params[:id])
  #     @questions = Question.find_by_answer_id(params[:id])
  #   end
  
  def details
  	@question = Question.find_by_id(params[:id])
    @new_answer = Answer.new
    #details for all the votes on question
    @question_votes = Vote.for_voteable(@question)
    @answers = Answer.find_by_question_id(params[:id])
    #details for all the votes on answers sorted by #votes 
    @answers_votes = Vote.for_voteable(@answers).descending
    
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
  

  
end