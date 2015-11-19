class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:edit, :update, :destroy, :show]

  def index
    @users = User.page(params[:page])
  end

  def show
  end

  def new
  end

  def create
    @user = User.create(user_create_params)

    if @user.save
      role_manager(params, @user)

      flash[:success] = "user created!"
      redirect_to admin_users_path
    else
      flash[:error] = "Create user failed!"
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_with_password(user_update_params)
      role_manager(params, @user)
      
      flash[:success] = "user updated!"
      redirect_to admin_users_path
    else
      flash[:error] = "Update user failed!"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = "User deleted!"
    else
      flash[:error] = "Delete user failed!"
    end
    redirect_to admin_users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_create_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def user_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password)
  end

  def role_manager(params, user)
    if params[:roles].present?
      user.roles.destroy_all
      params[:roles].map{ |role| add_new_role(user, role) }
    end
    
    add_new_role(user, params[:new_role]) if params[:new_role].present?
  end

  def add_new_role(user, role)
    user.add_role(role) if user.present? && role.present?
  end
end
