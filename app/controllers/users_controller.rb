class UsersController < ApplicationController

  def new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save # jsut returns false, doesn't throw errors
      #login user
      render :show
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end

    # render :show
  end

  def show
    @user = User.find_by_id(params[:id])
    render :show
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
