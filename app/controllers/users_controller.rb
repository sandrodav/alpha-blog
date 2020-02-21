class UsersController < ApplicationController
  before_action :set_user ,only:[:edit , :update , :show]
  before_action :require_same_user , only: [:edit , :update, :destroy ]
  before_action :require_admin ,only: [:destory]
  def index
    @users = User.order(:last_name).page(params[:page])

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to the Alpha Blog #{@user.username}"
      redirect_to users_path(@user)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Your acount was updated successfully"
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def show
    @user_article =@user.articles.order(:last_name).page(params[:page])
  end
   def destroy
     @user =User.find(params[:id])
     @user.destroy
     flash[:danger] ="User and all articles created by user have been deleted"
     redirect_to users_path
   end

  private
    def user_params
      params.require(:user).permit(:username , :email , :password )
    end
    def set_user
          @user = User.find(params[:id])
    end
    def require_same_user
      if  current_user  != @user and !current_user.admin?
        flash[:danger] = "You cen only edit your own account"
        redirect_to root_path
      end
    end
    def require_admin
      if logged_in? and !current_user.admin?
        flash[:denger] = "Only admin user can performe that action"
        redirect_to root_path
      end
    end
end
