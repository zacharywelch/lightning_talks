class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    user = User.from_omniauth(env['omniauth.auth'])

    if user.valid?
      session[:user_id] = user.id
      redirect_to request.env['omniauth.origin']
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
