class AddMoreUsers < ActiveRecord::Migration
  def up
    User.create!(:username => "shwartz.daniel",:first_name => "Daniel",
    :last_name => "Schwartz", :school_name => "Stanford School of Education",
    :password => "chalk", :password_confirmation => "chalk", :email => "daniel.schwartz@stanford.edu" )
  end

  def down
  end
end
