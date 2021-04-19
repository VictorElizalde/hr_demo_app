class CreateCandidates < ActiveRecord::Migration[5.2]
  def change
    create_table :candidates do |t|
      t.string :name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :linkedin_id
      t.string :facebook_id

      t.timestamps
    end
  end
end
