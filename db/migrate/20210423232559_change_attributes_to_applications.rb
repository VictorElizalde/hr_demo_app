class ChangeAttributesToApplications < ActiveRecord::Migration[5.2]
  def change
    rename_column :applications, :linked_in, :personal_site
    add_column :applications, :bio, :string
  end
end
