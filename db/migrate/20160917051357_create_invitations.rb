class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :event_id
      t.integer :user_id
      t.string :status, default: "pending"
      t.boolean :administrator, default: false

      t.timestamps
    end
  end
end
