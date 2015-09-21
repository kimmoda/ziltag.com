class ConfirmationsController < Devise::ConfirmationsController
  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    self.resource = resource_class.find_first_by_auth_conditions(confirmation_token: params[:confirmation_token])
  end

  # PUT /confirm
  def confirm
    self.resource = resource_class.find_first_by_auth_conditions(confirmation_token: params[resource_name][:confirmation_token])
    if resource.update permitted_params
      resource_class.confirm_by_token(params[resource_name][:confirmation_token])
      set_flash_message :notice, :confirmed
      sign_in_and_redirect(resource_name, resource)
    else
      render :show
    end
  end

private

  def permitted_params
    params.require(resource_name).permit(:confirmation_token, :password, :password_confirmation)
  end
end
