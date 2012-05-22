class LoadCategories < ActiveRecord::Migration
  def up
  	#create initial categories
  	category1 = Category.new(:name => "Technology")
  	category1.save(:validate => false)
  	category2 = Category.new(:name => "Special Education")
  	category2.save(:validate => false)
  	category3 = Category.new(:name => "Assessment")
  	category3.save(:validate => false)

  end

  def down
  
  end
end
