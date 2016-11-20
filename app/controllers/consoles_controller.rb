class ConsolesController < ApplicationController
  layout 'consoles'

  def index
    if logged_in?
      render :index
    else
      redirect_to sign_in_path
    end
  end
end
