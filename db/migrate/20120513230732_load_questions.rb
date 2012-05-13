class LoadQuestions < ActiveRecord::Migration
  def up
  	question1 = Question.new(:title => "Sharing Student IPad work", :description => "Sending invididual emails takes too long. Is there a better way to share work?",
  	:category_id => 1, :user_id => 1)
    question1.save(:validate=>false)
    question2 = Question.new(:title => "Coulton is not a quiet genius", :description => "Why is Coulton not a quiet genius?",
  	:category_id => 2, :user_id => 1)
    question2.save(:validate=>false)
  end

  def down
  end
end
