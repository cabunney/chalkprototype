class AddMoreUsers < ActiveRecord::Migration
  def up
    User.create!(:username => "shwartz.daniel",:first_name => "Daniel",
    :last_name => "Schwartz", :school_name => "Stanford School of Education",
    :password => "chalk", :password_confirmation => "chalk", :email => "daniel.schwartz@stanford.edu" )
    
     User.create!(:username => "azad.masi",:first_name => "Masi",
      :last_name => "Azad", :school_name => "Montclaire Elementary",
      :password => "chalk", :password_confirmation => "chalk", :email => "azad_masi@cusdk8.org" )
    
  end

  def down
  end
end
