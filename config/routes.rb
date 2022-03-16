# routing
Rails.application.routes.draw do
  resource :offsets, only: :update
  resources :users, only: :destroy do
    resources :temperatures, only: %i[create index]
  end
end
