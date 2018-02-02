# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
   before_action :configure_sign_up_params, only: [:create]
   before_action :configure_account_update_params, only: [:update]

 
  private
 
   def sign_up_params
     params.require(:user).permit(:name, :surname, :email, :password, :password_confirmation, :phone, :avatar)
   end
 
   def account_update_params
     params.require(:user).permit(:name, :surname, :email, :password, :password_confirmation, :current_password, :phone, :avatar)
   end



end
