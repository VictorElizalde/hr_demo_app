Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :companies
  resources :vacancies do
    resources :applications, only: [:new, :create, :update, :index, :show]
  end
  resources :candidates, only: [:index, :edit, :new, :create]

  root 'home#index'
  get 'admins', to: 'admins#index', as: 'admins'
  get 'users', to: 'users#index', as: 'users'
  get 'list_vacancies', to: 'vacancies#list_vacancies', as: 'list_vacancies'
  get 'see_vacancy/:id', to: 'vacancies#see_vacancy', as: 'see_vacancy'
  post "/delete_candidate/:id" => "candidates#delete_candidate", as: :delete_candidate
  patch "/candidate/:id" => "candidates#update", as: :update_candidate
  get "/candidate/:id" => "candidates#show", as: :candidate
  get 'applications', to: 'applications#index', as: 'applications'
  get 'candidates_admins', to: 'candidates#index_admins', as: 'candidates_admins'

  devise_for :candidates, controllers: { omniauth_callbacks: 'candidates/omniauth_callbacks' }
end
