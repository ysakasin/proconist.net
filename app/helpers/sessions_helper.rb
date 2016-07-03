module SessionsHelper
  def log_in(operator)
    session[:operator_id] = operator.id
  end

  def current_operator
    @current_operator ||= Operator.find_by(id: session[:operator_id])
  end

  def logged_in?
    !current_operator.nil?
  end
end
