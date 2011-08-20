class CreateAis < ActiveRecord::Migration
  def self.up
    create_table :ais do |t|
      t.string :name
      t.text :source
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :ais
  end
end
