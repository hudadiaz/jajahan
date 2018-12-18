Rails.application.routes.draw do
  root 'api#index'
  get ':name', to: 'api#show', as: :data
  get 'postcode/:name', to: 'api#postcode', as: :postcode
end
