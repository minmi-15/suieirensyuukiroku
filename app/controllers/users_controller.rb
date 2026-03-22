class UsersController < ApplicationController
  def show
    @user = current_user
    @posts = current_user.posts.order(created_at: :desc)

    @total_distance = current_user.posts.sum(:distance)

    @monthly_distance = current_user.posts
      .where(created_at: Time.current.all_month)
      .sum(:distance)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to mypage_path, notice: "更新しました"
    else
      render :edit
    end
  end

  def destroy
    current_user.destroy
    redirect_to root_path, notice: "退会しました"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end