class LoadUsers < ActiveRecord::Migration
  def up
    names = ["Norris Amanda","Auten Jennifer",  "Galante Kelly", "Chiou Jennifer",
      "Borghello Diana", "Kim Jenny","Hung Janny" ,"Masi Azad","Kridl Molly",
      "Cellini Mike","Barrango Sarah"];
    names.each do |name|
        n = name.split(" ")
        first = n[1]
        last = n[0]
        username = "#{first}.#{last}".downcase
        email = "#{last}_#{first}@cusdk8.org".downcase
        User.create!(:username => username,:first_name => first,
        :last_name => last, :school_name => "Montclaire Elementary",
        :password => "chalk", :password_confirmation => "chalk", :email => email)
      end
      
      User.create!(:username => "kim.cox",:first_name => "Kim",
      :last_name => "Cox", :school_name => "Montclaire Elementary",
      :password => "chalk", :password_confirmation => "chalk", :email => "kimberlykcox@yahoo.com" )

      User.create!(:username => "qian.wang",:first_name => "Qian",
      :last_name => "Wang", :school_name => "Stanford University",
      :password => "chalk", :password_confirmation => "chalk", :email => "firedove83@gmail.com" )

      User.create!(:username => "coulton.bunney",:first_name => "Coulton",
      :last_name => "Bunney", :school_name => "Stanford University",
      :password => "chalk", :password_confirmation => "chalk", :email => "cabunney@stanford.edu" )

      User.create!(:username => "sarah.chou",:first_name => "Sarah",
      :last_name => "Chou", :school_name => "Stanford University",
      :password => "chalk", :password_confirmation => "chalk", :email => "chou.sa@stanford.edu" )

      User.create!(:username => "debbie.stauffer",:first_name => "Debbie",
      :last_name => "Stauffer", :school_name => "Montclaire Elementary",
      :password => "chalk", :password_confirmation => "chalk", :email => "edebbie@mac.com" )      
      
  end

  def down
  end
  
end
