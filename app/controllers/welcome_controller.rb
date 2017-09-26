class WelcomeController < ApplicationController
  def index
    @talks = Talk.upcoming.includes(:user, :meeting).page(1)
  end
end
