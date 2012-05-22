class CreateStatistics < ActiveRecord::Migration
 def up
    create_table :statistics do |t|
	    t.column :likes,			:integer
	    t.column :pushes,       :integer
      t.column :views, 			  :integer
      t.column :question_id, 			:integer
      t.column :answer_id, 			  :integer
    end
  end
  def down
  	drop_table :statistics
  end
end
