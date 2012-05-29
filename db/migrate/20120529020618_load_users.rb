class LoadUsers < ActiveRecord::Migration
  def up
    names = ["Norris Amanda","Auten Jennifer",  "Galante Kelly", "Chiou Jennifer",
      "Borghello Diana", "Kim Jenny","Hung Janny" ,"Masi Azad","Kridl Molly",
      "Cellini Mike","Barrango Sarah"];
    names.each do |name|
        n = name.split[" "]
        first = n[1]
        last = n[0]
        username = "#{first}.#{last}".downcase
        email = "#{last}_#{first}@cusdk8.org".downcase
        Question.create!(:username => username,:first_name => first,
        :last_name => last, :school_name => "Montclaire Elementary",
        :password => "monty1160", :password_confirmation => "monty1160", :email => email)
      end
      
      Question.create!(:username => "kim.cox",:first_name => "Kim",
      :last_name => "Cox", :school_name => "Montclaire Elementary",
      :password => "monty1160", :password_confirmation => "monty1160", :email => "kimberlykcox@yahoo.com" )

      Question.create!(:username => "coulton.bunney",:first_name => "Coulton",
      :last_name => "Bunney", :school_name => "Montclaire Elementary",
      :password => "monty1160", :password_confirmation => "monty1160", :email => "cabunney@stanford.edu" )

      Question.create!(:username => "sarah.chou",:first_name => "Sarah",
      :last_name => "Chou", :school_name => "Montclaire Elementary",
      :password => "monty1160", :password_confirmation => "monty1160", :email => "chou.sa@stanford.edu" )
      
  end

  def down
  end
  
end
