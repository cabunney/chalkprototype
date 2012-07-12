class GraphController < ApplicationController
	def graph_questions
	   tags = Tag.all
	   @question_data = {}
	   @answer_data = {}
	   @names = []
	   @questions = []
	   @answers = []   
	   tags.each do |t|
	      @names << t.name
	      @questions << t.questions.size
	      @answers << t.answers.size
	      @question_data[t.name]=t.questions.size
	      @answer_data[t.name]=t.answers.size
     end
	end
	
	
end