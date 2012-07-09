class CreateTags < ActiveRecord::Migration
 def up
    create_table :tags do |t|
	    t.column :name,			:string
      t.column :user_id, 		:integer
    end
  end
  def down
  	drop_table :tags
  end
end
