Rails.application.routes.draw do
  namespace :address do
    resources :autocomplete, only: [:index]
  end
end

