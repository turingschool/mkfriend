class RenameOfficeAgain < ActiveRecord::Migration
  def change
    rename_column :games, :excluded_office, :excluded_cohort
  end
end
