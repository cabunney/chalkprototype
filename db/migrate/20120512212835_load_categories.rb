class LoadCategories < ActiveRecord::Migration
  def up
  	#create initial categories
  	category1 = Category.new(:name => "Technology", :question_id => 1, :answer_id => 1)
  	category1.save(:validate => false)
  	category2 = Category.new(:name => "Programs", :question_id => 1, :answer_id => 1)
  	category2.save(:validate => false)
  end

  def down
  end
end
