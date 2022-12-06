Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "referrals#index_by_service_provider"

  resources :referrals

  get ":service_provider/random", controller: "referrals", to: "referrals#random", as: :random_referral
end
