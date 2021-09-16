# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  Rails.application.routes.draw do
    apipie
    resources :merits_tasks, only: %i[create]
    namespace :proceeding_types do
      resources :threshold_waivers, only: %i[create]
    end
  end

  get 'ping', to: 'status#ping', format: :json
end
