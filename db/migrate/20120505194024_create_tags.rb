class CreateTags < ActiveRecord::Migration
 def up
    create_table :tags do |t|
	    t.column :name,			:string
      t.column :question_id, 	:integer
      t.column :answer_id, 		:integer
      t.column :user_id, 		:integer
      t.column :created_by, :integer
    end
  end
  def down
  	drop_table :tags
  end
end
