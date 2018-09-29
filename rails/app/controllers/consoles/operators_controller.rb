# rubocop:disable Style/ClassAndModuleChildren
# rubocop:disable Metrics/MethodLength

class Consoles::OperatorsController < Consoles::BaseController
  def show
    @operator = current_operator
    @schools = School.all
  end

  def update
    operator = current_operator
    if operator_params.key? 'current_password'
      if update_password operator, operator_params
        flash[:status] = 'pass_success'
      end
    else
      operator.update(operator_params)
      flash[:status] = 'success'
    end
    redirect_to console_user_settings_path
  end

  private

  def operator_params
    params.require(:operator).permit(
      :identifier,
      :name,
      :icon,
      :school_id,
      :github,
      :bitbucket,
      :slideshare,
      :twitter,
      :facebook,
      :site,
      :description,
      :current_password,
      :new_password,
      :new_password_confirmation
    )
  end

  def update_password(operator, passwords_hash)
    if operator == operator.authenticate(passwords_hash[:current_password])
      if passwords_hash[:new_password] == passwords_hash[:new_password_confirmation]
        operator.password = passwords_hash[:new_password]
        operator.password_confirmation = passwords_hash[:new_password_confirmation]
        operator.save
      else
        flash[:status] = 'verify_error'
        false
      end
    else
      flash[:status] = 'auth_error'
      false
    end
  end
end
