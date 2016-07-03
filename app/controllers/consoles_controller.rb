class ConsolesController < ApplicationController
  def index
    if logged_in?
      render :index, layout: 'layouts/consoles'
    else
      redirect_to sign_in_path
    end
  end
end
