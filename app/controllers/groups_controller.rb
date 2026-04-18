class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      redirect_to groups_path
    else
      render :new
    end
  end

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def edit
    @group = Group.find(params[:id])
    redirect_to groups_path unless @group.owner_id == current_user.id
  end

  def update
    @group = Group.find(params[:id])
    if @group.owner_id == current_user.id 
      @group.update(group_params)
      redirect_to group_path(@group)
    else
      redirect_to groups_path
    end
  end

  def join
    group = Group.find(params[:group_id])
    group.users << current_user
    redirect_to group_path(group)
  end

  def leave
    group = Group.find(params[:group_id])
    group.users.delete(current_user)
    redirect_to group_path(group)
  end

  def new_event
    @group = Group.find(params[:group_id])
  end

  def send_event
    group = Group.find(params[:group_id])
    group.users.each do |user|
      EventMailer.notice_event(user, params[:title], params[:body]).deliver_now
    end
    flash[:notice] = "送信が完了しました"
    redirect_to group_path(group)
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction)
  end
end