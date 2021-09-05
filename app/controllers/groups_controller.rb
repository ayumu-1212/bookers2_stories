class GroupsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @new_group = Group.new
  end
  
  def create
    @new_group = Group.new(group_params)
    @new_group.owner_id = current_user.id
    if @new_group.save
      flash[:notice] = "グループを作成しました"
      redirect_to groups_path
    else
      render :new
    end
  end
  
  def index
    @groups = Group.all
    @new_book = Book.new
  end
  
  def show
    @group = Group.find(params[:id])
    @new_book = Book.new
    @user = @group.owner
  end
  
  def edit
    @group = Group.find(params[:id])
  end
  
  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      flash[:notice] = "更新が完了しました"
      redirect_to groups_path
    else
      render :edit
    end
  end
  
  def join
    GroupUser.find_or_create_by(user_id: current_user.id, group_id: params[:id])
    redirect_back(fallback_location: groups_path)
  end
  
  def leave
    group_user = GroupUser.find_by(user_id: current_user.id, group_id: params[:id])
    group_user.destroy
    redirect_back(fallback_location: groups_path)
  end
  
  def new_notice
    @group = Group.find(params[:id])
    @new_event_notice = EventNotice.new
  end
  
  def create_notice
    @group = Group.find(params[:id])
    @new_event_notice = EventNotice.new(event_notice_params)
    @new_event_notice.user_id = current_user.id
    @new_event_notice.group_id = @group.id
    if @new_event_notice.save
      EventNoticeMailer.send_to_group_members(@new_event_notice).deliver
      redirect_to complete_notice_group_path(@new_event_notice)
    else
      render :new_notice
    end
  end
  
  def complete_notice
    @event_notice = EventNotice.find(params[:id])
    @users = @event_notice.group.users
  end
  
  private
  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end
  
  def event_notice_params
    params.require(:event_notice).permit(:title, :body)
  end
end
