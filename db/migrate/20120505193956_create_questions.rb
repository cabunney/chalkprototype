class CreateQuestions < ActiveRecord::Migration
  def up
    create_table :questions do |t|
	  t.column :title,			    :string
	  t.column :description,	  :text
	  t.column :category_id, 		  :integer
	  t.column :user_id, 	    	:integer
    t.column :created_at, 		:timestamp 
    t.column :statistic_id, 	:integer
    end
  end

  def down
  	drop_table :questions
  end 	
end
