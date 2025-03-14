Rails.application.routes.draw do
    get "up" => "rails/health#show", as: :rails_health_check

    namespace :api do
        namespace :v1 do
            resources :customers, only: :index
            resources :teas, only: :index
            resources :subscriptions, only: [:index, :show] do
                resources :subscription_customers, only: [:update]
            end
        end
    end
end
