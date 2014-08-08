class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.timestamps
      t.belongs_to :game
      t.belongs_to :person
      t.integer :position
      t.integer :guessed_person_id
    end
  end
end
