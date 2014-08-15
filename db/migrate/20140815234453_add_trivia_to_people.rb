class AddTriviaToPeople < ActiveRecord::Migration
  def change
    add_column :people, :trivia, :text, null: false, default: ""
  end
end
