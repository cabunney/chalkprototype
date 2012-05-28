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
    @question_votes = Vote.for_voteable(@question).descending
    @answers = @question.answers.sort{ |x,y| y.votes_for <=> x.votes_for }
    @progress = @question.pushes_for.to_f/User.find(:all).count.to_f * 100
    #details for all the votes on answers sorted by #votes 
    #@answers_votes = Vote.for_voteable(@question.answers).descending   
  end
  

  def post_answer
      if !signed_in?
        flash.now[:error] = "Please log in before submitting an answer."
        redirect_to(:action => :details, :id => params[:id])
      else 
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
  
  def post_vote
    if !signed_in?
      flash.now[:error] = "Please log in before voting."
      redirect_to(:action => :details, :id => params[:id])
    else
    	if (params[:type] == "Answer")
    	  @item = Answer.find_by_id(params[:id])
    	elsif
        @item = Question.find_by_id(params[:id])
      end
    	current_user.vote_for(@item)
    	respond_to do |format|
        format.js { render :content_type => 'text/javascript', :action => "post_vote", :layout => false }
      end
    end
  end
    
  
  def post_push
    if !signed_in?
      flash.now[:error] = "Please log in before pushing."
      redirect_to(:action => :details, :id => params[:id])
    else
      @item = Question.find_by_id(params[:id])
      current_user.push_for(@item)
    	respond_to do |format|
        format.js { render :content_type => 'text/javascript', :action => "post_push", :layout => false }
      end
    end
  end

  
end