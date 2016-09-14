class AddNamesToUser < ActiveRecord::Migration
  def change
    add_column :users, :family_name, :string
    add_column :users, :first_name, :string
  end
end
