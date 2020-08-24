module Api
  module V1
      class RegistrationsController < DeviseTokenAuth::RegistrationsController
        private
        def sign_up_params
          params.permit(:name, :nickname, :email, :img, :password, :password_confirmation)
        end

        def account_update_params
          params.permit(:name, :nickname, :email, :img)
        end
    end
  end
end
