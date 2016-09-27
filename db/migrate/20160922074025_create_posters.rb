class CreatePosters < ActiveRecord::Migration
  def change
    create_table :posters do |t|
      t.text :title
      t.text :detail
      t.text :place
      t.text :address
      t.string :date
      t.string :time
      t.text :image_url
      t.text :link_url
      t.string :reference

      t.timestamps null: false
    end
  end
end
