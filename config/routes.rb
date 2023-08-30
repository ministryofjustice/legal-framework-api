# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"

  resources :merits_tasks, param: :ccms_code, only: %i[create]
  resources :civil_merits_questions, param: :ccms_code, only: %i[create]

  get "client_involvement_types", to: "client_involvement_types#index"
  get "organisation_types/all", to: "organisation_types#index"
  get "proceeding_types/all", to: "proceeding_types/searches#index"

  resources :proceeding_types, param: :ccms_code, only: %i[show]
  namespace :proceeding_types do
    resources :threshold_waivers, only: %i[create]
    resources :searches, only: %i[create]
  end

  get "organisation_searches/all", to: "organisation_searches#index"
  post "organisation_searches", to: "organisation_searches#create"

  resources :organisation_types, param: :ccms_code, only: %i[show]
  resources :threshold_waivers, only: %i[create]
  resources :proceeding_type_defaults, only: %i[create]
  resources :proceeding_type_scopes, only: %i[create]

  root to: "main#index"

  get "ping", to: "status#ping", format: :json
  get "status", to: "status#status", format: :json
end
