class AddBioAndTitleToPeople < ActiveRecord::Migration
  def change
    add_column :people, :bio, :text
    add_column :people, :title, :string
  end
end
