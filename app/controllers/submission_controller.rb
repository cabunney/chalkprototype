class SubmissionController < ApplicationController
	def QS
		@categories = Category.find(:all, :order =>'id DESC');
		@question = Question.new
      
	end
	
	def showQ
		
	end
	
	def submitQ
		@question = Question.new
		 if @question.update_attributes(params[:question]) then
    		redirect_to(:action => :showQ)
  		else
   			 render(:action => :QS)
  		end
	end
	
	def AS
	
	end	
	
	def showA
  end
  
	def submit_answer
		@answer = Answer.new
		 if @answer.update_attributes(params[:answer]) then
    		redirect_to(:action => :showA)
  		else
   			 render(:action => :AS)
  		end
	end
	 
end