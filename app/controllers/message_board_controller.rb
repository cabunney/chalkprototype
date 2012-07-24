require 'will_paginate/array'

class MessageBoardController < ApplicationController
  def show
    if !signed_in?
      flash[:error] = "Please log in to see the message board."
      redirect_to root_path
    else
      @questions = Question.find(:all).sort{ |x,y| y.votes_for <=> x.votes_for }.paginate(:page => params[:page], :per_page => 10)   
      # @questions.each do |q|
      #         impressionist(q) 
      #      end
      @answers = Answer.find(:all)  
      @categories = Category.find(:all, :order =>'id DESC')
  		@question = Question.new   
      @tags = []
      @top_tags = Tag.find(:all)
    end
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
     if !signed_in?
        flash[:error] = "Please log in to see this question."
        redirect_to root_path
    else
      @tags = []
      @top_tags = Tag.find(:all)
  	  @question = Question.find_by_id(params[:id])
      @new_answer = Answer.new
      #details for all the votes on question
      @question_votes = Vote.for_voteable(@question).descending
      @answers = @question.answers.sort{ |x,y| y.votes_for <=> x.votes_for }
      @progress = @question.pushes_for.to_f/User.find(:all).count.to_f * 100
      #details for all the votes on answers sorted by #votes 
      #@answers_votes = Vote.for_voteable(@question.answers).descending   
    end
  end
  

  def post_answer
      if !signed_in?
        flash[:error] = "Please log in before submitting an answer."
        redirect_to root_path
      else
          
  	  @question = Question.find_by_id(params[:id])
  	  @answers = @question.answers.sort{ |x,y| y.votes_for <=> x.votes_for }
  	  @progress = @question.pushes_for.to_f/User.find(:all).count.to_f * 100
  	  @new_answer = Answer.new
  		if params[:answer][:title]== "Enter idea title..." 
  		   flash.now[:error] = "Please enter a title for your answer"
  		   render(:action => :details, :id => params[:id])
  	  elsif params[:answer][:title]== "Enter idea description..." 
  	     flash.now[:error] = "Please enter a description for your answer"
  		   render(:action => :details, :id => params[:id])
  	  elsif @new_answer.update_attributes(params[:answer]) then
      		flash[:success] = "Successfully posted your answer!"
          redirect_to(:action => :details, :id => params[:id])
    	else
    		  flash.now[:error] = @new_answer.errors.full_messages
          render(:action => :details, :id => params[:id])
    	end
  	end
  end
  
  def post_vote
    if !signed_in?
      flash[:error] = "Please log in before voting."
      redirect_to root_path
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
    
def post_vote_detail
    if !signed_in?
      flash[:error] = "Please log in before voting."
      redirect_to root_path
    else
    	if (params[:type] == "Answer")
    	  @item = Answer.find_by_id(params[:id])
    	elsif
        @item = Question.find_by_id(params[:id])
      end
    	current_user.vote_for(@item)
    	respond_to do |format|
        format.js { render :content_type => 'text/javascript', :action => "post_vote_detail", :layout => false }
      end
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
  		  @tags=[]
   			 render(:action => :_dynamicinput_question)
  		end

	end
	
  def submitA
		 # if !signed_in?
		 #         flash[:error] = "Please log in before submitting an answer."
		 #         redirect_to root_path
		 #       else
          
  	  @question = Question.find_by_id(params[:id])
  	  @answers = @question.answers.sort{ |x,y| y.votes_for <=> x.votes_for }
      # @progress = @question.pushes_for.to_f/User.find(:all).count.to_f * 100
  	  @new_answer = Answer.new
  	  @tags_string = params[:new_answer][:tags]
  	  @tags = @tags_string.split(",")
  	  @new_tags = []
  		params[:new_answer][:tags] = @new_tags
  		if @new_answer.update_attributes(params[:new_answer]) then
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
        @new_answer.tags = @new_tags
        @tags = []
  		     flash[:success] = "Successfully posted your answer!"
      		 redirect_to(:controller => :message_board, :action => :details, :id => params[:id])
    		else
    		  @tags=[]
     			 render(:action => :_dynamicinput_answer)
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


  
end