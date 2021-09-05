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
  
  private
  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end
end
