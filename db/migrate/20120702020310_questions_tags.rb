class QuestionsTags < ActiveRecord::Migration
    def up
        create_table :questions_tags, :id => false do |t|
              t.references :question    
      	      t.references :tag	 
         end
         add_index :questions_tags, [:question_id, :tag_id]
         add_index :questions_tags, [:tag_id, :question_id]
    end

    def down
      drop_table :questions_tags
    end
 end
