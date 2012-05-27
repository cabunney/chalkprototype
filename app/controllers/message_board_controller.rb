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
  
  def post_vote
  #  $("widget<%=@widget.id%>").update("<%=@text%>");
  #  new Effect.Highlight("widget<%=@widget.id%>", {duration: 1.5, startcolor: "<%=@start_color%>"});
    	#console.log("is this getting called?")
    	if (params[:type] == "Answer")
    	  @item = Answer.find_by_id(params[:id])
    	elsif
        @item = Question.find_by_id(params[:id])
      end
    	current_user.vote_for(@item)
    	#format.js { render :action => "post_vote", :locals => {:item => @item}, :layout => false }
      respond_to do |format|
        #format.js { render :content_type => 'text/javascript', :action => "post_vote" }
        format.js { render :content_type => 'text/javascript', :action => "post_vote", :layout => false }
        #format.js  { render(:post_vote) do |page| page.replace_html 'vote_2', :partial => 'voting_item', :locals => {:item => @item} end}
      end
  end
    
  

  
end