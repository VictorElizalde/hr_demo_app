Rails.application.routes.draw do
  namespace :v1, defaults: { format: 'json' } do
    namespace :admin do
      resources :companies, except: [:new, :edit]
      resources :vacancies, only: [:new, :create, :edit, :update, :index, :show, :destroy] do
        resources :applications, only: [:update, :index]
      end
      resources :candidates, only: [:index, :edit]
      resources :administrators, only: [:index, :edit, :new, :create]
      post "/delete_candidate/:id" => "candidates#delete_candidate", as: :delete_candidate
      patch "/candidate/:id" => "candidates#update", as: :update_candidate
      get "/candidate/:id" => "candidates#show", as: :candidate
      post "/delete_administrator/:id" => "administrators#delete_administrator", as: :delete_administrator
      patch "/administrator/:id" => "administrators#update", as: :update_administrator
      get "/administrator/:id" => "administrators#show", as: :administrator
      get 'candidates_admins', to: 'candidates#index_admins', as: 'candidates_admins'
      get 'applications', to: 'applications#index', as: 'applications'
      get 'admins', to: 'admins#index', as: 'admins'
    end

    resources :vacancies, except: [:new, :create, :edit, :update, :index, :show, :destroy] do
      resources :applications, only: [:new, :create]
    end

    root 'home#index'
    get 'users', to: 'users#index', as: 'users'
    get 'list_vacancies', to: 'vacancies#list_vacancies', as: 'list_vacancies'
    get 'see_vacancy/:id', to: 'vacancies#see_vacancy', as: 'see_vacancy'
    resources :candidates, only: [:create]
  end

  devise_for :candidates, controllers: { 
    omniauth_callbacks: 'candidates/omniauth_callbacks',
    registrations: 'v1/custom_devise/registrations',
    confirmations: 'v1/custom_devise/confirmations',
    sessions: 'v1/custom_devise/sessions'
  }
end