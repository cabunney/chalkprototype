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
   			 render(:action => :edit)
  		end
	end
	
	def AS
	
	end	
	
	 
end