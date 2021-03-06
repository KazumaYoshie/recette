class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @posts = @user.post.page(params[:page]).per(5)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
      flash[:notice] = "更新しました"
    else
      render :edit
    end
  end

  def hide
    @user = User.find(params[:id])
    @user.update(is_valid: false)
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :intro)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(posts_path) unless @user == current_user
  end
end
