class UpdateQuestion < ActiveRecord::Migration
  def up
  	rename_column :questions, :category, :category_id
  end

  def down
  	rename_column :questions, :category_id, :category
  end
end
