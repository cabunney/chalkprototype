class CreateAnswers < ActiveRecord::Migration
  def up
    create_table :answers do |t|
	    t.column :title,			:string
	    t.column :description,	:string
	    t.column :category_id, 		:integer
	    t.column :user_id, 		  :integer
      t.column :created_at,      :timestamp
      t.column :question_id, 	:integer
      t.column :statistic_id, 	:integer
    end
  end
  def down
  	drop_table :answers
  end
end
