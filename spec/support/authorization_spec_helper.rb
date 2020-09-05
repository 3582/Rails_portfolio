module AuthorizationSpecHelper
  def sign_up(user)
    post '/api/v1/auth', :params => { :email => user[:email], :password => user[:password], :password_confirmation => user[:password_confirmation] }, :as => :json

    response.headers.slice('client', 'access-token', 'uid')
  end

  def sign_in(user)
    post '/api/v1/auth/sign_in', :params => { :email => user[:email], :password => user[:password] }, :as => :json
    response.headers.slice('client', 'access-token', 'uid')
  end
end
