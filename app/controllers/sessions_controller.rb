class SessionsController < ApplicationController
  def new
    render :new, layout: false
  end
end
