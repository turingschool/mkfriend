class ChangeOfficeToCohort < ActiveRecord::Migration
  def change
    rename_column :people, :office, :cohort
  end
end
