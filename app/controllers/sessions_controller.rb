class SessionsController < ApplicationController
  def new
    render :new, layout: false
  end

  def create
    operator = Operator.find_by(identifier: params[:session][:identifier])
    if operator && operator.authenticate(params[:session][:password])
      log_in operator
      redirect_to console_path
    else
      redirect_to sign_in_path
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
