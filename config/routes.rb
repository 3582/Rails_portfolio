Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', :at => 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    scope :v1 do
      mount_devise_token_auth_for 'User', :at => 'auth', :controllers => {
          :registrations => 'api/v1/registrations'
      }
    end
  end

  namespace :api, :format => 'json' do
    namespace :v1 do
      resources :posts
      get 'posts/ranking/:order/:limit' => 'posts#ranking'
      get 'posts/:tag_name/:order/:limit' => 'posts#posts_with_tagname'

      resources :tags
    end
  end
end
