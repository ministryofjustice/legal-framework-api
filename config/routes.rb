# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  Rails.application.routes.draw do
    apipie
    resources :merits_tasks, param: :ccms_code, only: %i[create]
    get "proceeding_types/all", to: "proceeding_types/searches#index"
    resources :proceeding_types, param: :ccms_code, only: %i[show]
    namespace :proceeding_types do
      resources :threshold_waivers, only: %i[create]
      resources :searches, only: %i[create]
    end
  end

  get "ping", to: "status#ping", format: :json
end
