class ConfirmationsController < Devise::ConfirmationsController
  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    @confirmation_token = params[:confirmation_token]
    self.resource = resource_class.find_first_by_auth_conditions(confirmation_token: @confirmation_token)
    track 'visit-confirmation'
  end

  # PUT /confirm
  def confirm
    self.resource = resource_class.find_first_by_auth_conditions(confirmation_token: params[resource_name][:confirmation_token])
    self.resource.define_singleton_method(:password_required?){ true }
    if resource.update permitted_params
      resource_class.confirm_by_token(params[resource_name][:confirmation_token])
      sign_in(resource_name, resource)
      render :welcome
      track 'input-password'
    else
      @confirmation_token = params[resource_name][:confirmation_token]
      render :show
      track 'input-password', 'failure'
    end
  end

private

  def permitted_params
    params.require(resource_name).permit(:confirmation_token, :password, :password_confirmation)
  end
end
