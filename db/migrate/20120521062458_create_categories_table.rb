class CreateCategoriesTable < ActiveRecord::Migration
  def up
      create_table :categories do |t|
  	    t.column :name,	:string
  	    t.column :question_id, :string
  	    t.column :answer_id, :string        
      end
  end

  def down
    drop_table :categories
  end
end
