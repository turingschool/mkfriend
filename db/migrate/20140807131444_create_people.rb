class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.timestamps
      t.text :image_url, unique: true, null: false
      t.text :name, unique: true, null: false
      t.text :description
    end
  end
end
