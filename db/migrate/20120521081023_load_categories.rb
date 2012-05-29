class LoadCategories < ActiveRecord::Migration
  def up
  	cats = ["Assessment","Common Core","Lesson Plans", 
    "Literacy", "Parents",  "Professional Learning",
    "Resources","Technology"]
    cats.each do |c|
      Category.create!(c)
    end  
  end

  def down
  end
end
