# frozen_string_literal: true

Rails.application.routes.draw do
  resources :vehicles, only: %i[create destroy] do
    resources :locations, only: [:create]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
