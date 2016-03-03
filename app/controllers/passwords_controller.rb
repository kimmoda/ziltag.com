class PasswordsController < Devise::PasswordsController
  prepend_before_action :sign_out, only: :edit
end