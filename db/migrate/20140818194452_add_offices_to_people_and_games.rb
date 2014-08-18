class AddOfficesToPeopleAndGames < ActiveRecord::Migration
  def change
    add_column :people, :office, :string
    add_column :games, :excluded_office, :string
  end
end
