Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  root "urls#new"

  resources :urls, only: [:index, :new, :create, :show]

  # Sample long route for demonstration
  get '/very/long/sample/path/for/demo', to: 'urls#sample', as: :sample_long_route

  get '/:short_url', to: 'urls#redirect', as: :short

  namespace :api do
    namespace :v1 do
      resources :urls, only: [:create]
    end
  end
end
