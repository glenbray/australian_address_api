Rails.application.routes.draw do
  get "/address/autocomplete", controller: :address_autocomplete, action: :index
  get "/coordinates/reversegeocode", controller: :reverse_geocode, action: :index
end

