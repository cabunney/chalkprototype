class PushFuMigration < ActiveRecord::Migration
  def self.up
    create_table :pushes, :force => true do |t|
      t.boolean    :push, :default => false
      t.references :pushable, :polymorphic => true, :null => false
      t.references :pusher,    :polymorphic => true
      t.timestamps      
    end

    add_index :pushes, ["pusher_id", "pusher_type"],       :name => "fk_pushers"
    add_index :pushes, ["pushable_id", "pushable_type"], :name => "fk_pushables"

    # If you want to enfore "One Person, One Push" rules in the database, uncomment the index below
    add_index :pushes, ["pusher_id", "pusher_type", "pushable_id", "pushable_type"], :unique => true, :name => "uniq_one_push_only"
  end
 
  def self.down
    drop_table :pushes
  end

end
