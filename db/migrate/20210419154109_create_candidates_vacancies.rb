class CreateCandidatesVacancies < ActiveRecord::Migration[5.2]
  def change
    create_table :candidates_vacancies, id: false do |t|
      t.belongs_to :candidate
      t.belongs_to :vacancy
    end
  end
end
