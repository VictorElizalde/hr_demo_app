class CreateVacancies < ActiveRecord::Migration[5.2]
  def change
    create_table :vacancies do |t|
      t.string :title
      t.string :description
      t.string :min_salary
      t.string :max_salary
      t.datetime :published_at
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
