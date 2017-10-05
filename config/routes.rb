Rails.application.routes.draw do
  root 'links#index'
  resources :links
  get ":short_url", to: "links#show"
  get "shortened/:short_url", to: "links#shortened", as: :shortened
end
