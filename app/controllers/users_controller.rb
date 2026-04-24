class UsersController < ApplicationController
  def show
    @user = current_user
    @posts = current_user.posts

    @total_distance = @posts.sum(:distance)
    @monthly_distance = @posts
      .where(created_at: Time.current.all_month)
      .sum(:distance)
    @posts = @posts.where("title LIKE ?", "%#{params[:title]}%") if params[:title].present?
    @posts = @posts.where(stroke: params[:stroke]) if params[:stroke].present?
    @posts = @posts.order("#{ params[:order_column] } #{ params[:order_method] }")
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