class AddPosternumToEvent < ActiveRecord::Migration
  def change
    add_column :events, :poster_id, :integer, default: 0
    add_column :events, :status, :string, default: "0"
  end
end
