class Admin::UsersController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    @keyword = params[:keyword]
    @users = if @keyword.present?
              User.where("name LIKE ? OR email LIKE ?", "%#{@keyword}%", "%#{@keyword}%")
             else
              User.all
             end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:notice] = "削除しました"
    redirect_to admin_users_path
  end
end
