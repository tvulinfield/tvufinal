class UsersController < ApplicationController
  def new
  	@user = User.new
  end
  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # Handle a successful save.
      flash[:success] = "Welcome to the CollegeNet!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :school, :email, :password,
                                   :password_confirmation)
    end


end
