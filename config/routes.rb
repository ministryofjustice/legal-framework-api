# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :merits_tasks, param: :ccms_code, only: %i[create]
  get "proceeding_types/all", to: "proceeding_types/searches#index"
  get "client_involvement_types", to: "client_involvement_types#index"
  resources :proceeding_types, param: :ccms_code, only: %i[show]
  namespace :proceeding_types do
    resources :threshold_waivers, only: %i[create]
    resources :searches, only: %i[create]
  end

  root to: "main#index"

  get "ping", to: "status#ping", format: :json
  get "status", to: "status#status", format: :json
end
