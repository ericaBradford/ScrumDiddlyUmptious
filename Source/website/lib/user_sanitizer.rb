class User::ParameterSanitizer < Devise::ParameterSanitizer
    private

      def sign_in
        default_params.permit(:userName, :password, :remember_me)
      end

      def sign_up
        default_params.permit(:userName, :email, :password, :password_confirmation)
      end

      def account_update
        default_params.permit(:userName, :email, :password, :password_confirmation, :current_password)
      end
end