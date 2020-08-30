Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  namespace :api do
    scope :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
          registrations: 'api/v1/registrations'
      }
    end
  end

  namespace :api, format: 'json' do
    namespace :v1 do
      resources :posts
      resources :images, only: :create do
        collection do
          get :fetch_latest_image
        end
      end
    end
  end
end
