class AddOmniauthToCandidates < ActiveRecord::Migration[5.2]
  def change
    add_column :candidates, :provider, :string
    add_column :candidates, :uid, :string
  end
end
