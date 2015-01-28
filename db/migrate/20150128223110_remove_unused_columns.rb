class RemoveUnusedColumns < ActiveRecord::Migration
  def change
    remove_column :people, :bio
    remove_column :people, :trivia
  end
end
