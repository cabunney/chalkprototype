class CreateAnswers < ActiveRecord::Migration
  def up
    create_table :answers do |t|
	    t.column :title,			:string
	    t.column :description,	:text
	    t.column :category_id, 		:integer
	    t.column :user_id, 		  :integer
      t.column :created_at,      :timestamp
      t.column :question_id, 	:integer
      t.column :statistic_id, 	:integer
      t.column :impressions_count, :integer
    end
  end
  
  def down
  	drop_table :answers
  end
end
