class CreateCategories < ActiveRecord::Migration
 def up
    create_table :categories do |t|
	  t.column :name,			:string
      t.column :question_id, 	:integer
      t.column :answer_id, 		:integer
    end
  end
  def down
  	drop_table :categories
  end
end
