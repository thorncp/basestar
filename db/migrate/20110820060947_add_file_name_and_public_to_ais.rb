class AddFileNameAndPublicToAis < ActiveRecord::Migration
  def change
    add_column :ais, :file_name, :string
    add_column :ais, :public, :boolean
  end
end
