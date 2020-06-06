Rails.application.routes.draw do
  get "/address/autocomplete", controller: :address_autocomplete, action: :index
end

