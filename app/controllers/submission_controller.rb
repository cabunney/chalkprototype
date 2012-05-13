class SubmissionController < ApplicationController
	def QS
		@categories = Category.find(:all, :order =>'id DESC');
		@question = Question.new
		
	end
	
	def AS
	
	end	
end