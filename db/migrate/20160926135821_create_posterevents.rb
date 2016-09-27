class CreatePosterevents < ActiveRecord::Migration
  def change
    create_table :posterevents do |t|
      t.integer :event_id
      t.integer :poster_id

      t.timestamps null: false
    end
  end
end
