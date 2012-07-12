class AnswersTags < ActiveRecord::Migration
  def up
      create_table :answers_tags, :id => false do |t|
            t.references :answer 
    	      t.references :tag			 
       end
       add_index :answers_tags, [:answer_id, :tag_id]
       add_index :answers_tags, [:tag_id, :answer_id]
  end

  def down
    drop_table :answers_tags
  end
end
