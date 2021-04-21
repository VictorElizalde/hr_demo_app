class DeleteCandidatesVacanciesTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :candidates_vacancies
  end
end
