class AnswersTags < ActiveRecord::Migration
  def up
      create_table :answers_tags do |t|
            t.column :answer_id,        :integer
    	      t.column :tag_id,			 :integer
       end
    
  end

  def down
    drop_table :answers_tags
  end
end
