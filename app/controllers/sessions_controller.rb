class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(
              session_params[:email],
              session_params[:password]
            )
    if @user.nil?
      flash.now[:errors] = ["Invalid Username and Password Combo"]
      render :new
    else
      @user.reset_session_token!
      session[:token] = @user.session_token
      redirect_to user_url(@user.id)
    end
  end


  def destroy
    if current_user
      current_user.reset_session_token!
      session[:token] = nil
    end

    render :new
  end


  private
  def session_params
    params.require(:user).permit(:email, :password)
  end
end
