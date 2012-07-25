class LoadCategories < ActiveRecord::Migration
  def up
  	cats = ["Administrator","New Teacher","Common Core","Lesson Plans", 
    "Literacy", "Parents",  "Professional Learning",
    "Resources","Technology"]
    cats.each do |c|
      Category.create!(:name=>c)
    end  
  end

  def down
  end
end
