class LanderController < ApplicationController
  def show
    render template: "lander/#{params[:id]}"
  end
end