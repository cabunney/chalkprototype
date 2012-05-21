class MessageBoardController < ApplicationController
  def show
    @questions = Question.find(:all)
    @answers = Answer.find(:all)
    @ans_user_map = {}
    @ans_questions_map = {}
    @answers.each do |a| 
        user = User.find(a.user_id)
        question = Question.find(a.question_id)
        @ans_user_map[a.id]=user
        @ans_questions_map[a.id]=question
    end 
  end
  
  def question
    @question = Question.find(params[:id])
    @answers = Answer.find_by_question_id(params[:id])
  end
  
  def answer
    @answer = Answer.find(params[:id])
    @questions = Question.find_by_answer_id(params[:id])
  end
  
end