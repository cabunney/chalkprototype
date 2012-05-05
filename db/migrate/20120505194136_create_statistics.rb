class CreateStatistics < ActiveRecord::Migration
 def up
    create_table :statistics do |t|
	  t.column :likes,			:integer
      t.column :views, 			:integer
    end
  end
  def down
  	drop_table :statistics
  end
end
