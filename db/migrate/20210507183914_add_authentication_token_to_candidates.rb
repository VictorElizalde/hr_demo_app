class AddAuthenticationTokenToCandidates < ActiveRecord::Migration[5.2]
  def change
    add_column :candidates, :authentication_token, :string, limit: 30
    add_index :candidates, :authentication_token, unique: true
  end
end
