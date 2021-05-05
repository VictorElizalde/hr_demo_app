json.vacancies @vacancies do |vacancy|
  json.id vacancy.id
  json.title vacancy.title
  json.company_name vacancy.company.name
  json.salary_range "#{vacancy.min_salary}K - #{vacancy.max_salary}K"
end
