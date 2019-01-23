class AddAttrsToUser < ActiveRecord::Migration[5.2]

  def up
    add_column :users, :name, :string
    add_column :users, :avatar, :string
    add_column :users, :document, :string
  end

  def down
    remove_column :users, :name
    remove_column :users, :avatar
    remove_column :users, :document
  end
end
