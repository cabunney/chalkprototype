class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
        t.column :username,       :string
	      t.column :first_name,			:string
        t.column :last_name, 			:string
        t.column :school_name, 		:string
        t.column :password, 			:string
        t.column :password_confirmation, 		:string
        t.column :password_digest, 			    :string
        t.column :account_type,		:string
        t.column :email, 				  :string
      end
      
  end
  
  def down
  	drop_table :users
  end
end
