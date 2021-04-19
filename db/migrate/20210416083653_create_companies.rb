class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :contact_name
      t.string :contact_last_name
      t.string :contact_phone
      t.string :contact_email
      t.string :website

      t.timestamps
    end
  end
end
