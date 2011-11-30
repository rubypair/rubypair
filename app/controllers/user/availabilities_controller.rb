class User::AvailabilitiesController < ApplicationController
  before_filter do
    @user = User.find(params[:user_id])
    @user.extend User::Availability
  end

  def create
    @user.available!
    render status: 201, nothing: true
  end

  def destroy
    @user.unavailable!
    render status: 200, nothing: true
  end
end
