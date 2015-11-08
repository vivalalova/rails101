class GroupsController < ApplicationController
  # before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy] 
  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @group = Group.find(params[:id])
    @posts = @group.posts
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
      @group = current_user.groups.find(params[:id])
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = current_user.groups.new(group_params)
   if @group.save
      current_user.join!(@group)
      redirect_to groups_path
   else
     render :new
   end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    @group = current_user.groups.find(params[:id])

  if @group.update(group_params)
    redirect_to groups_path, notice: "修改討論版成功"
  else
    render :edit
  end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group = current_user.groups.find(params[:id])
   @group.destroy
   redirect_to groups_path, alert: "討論版已刪除"
  end

  def join
    @group = Group.find(params[:id])
 
    if !current_user.is_member_of?(@group)
      current_user.join!(@group)
      flash[:notice] = "加入本討論版成功！"
    else
      flash[:warning] = "你已經是本討論版成員了！"
    end
 
    redirect_to group_path(@group)
  end
 
  def quit
    @group = Group.find(params[:id])
 
    if current_user.is_member_of?(@group)
      current_user.quit!(@group)
      flash[:alert] = "已退出本討論版！"
    else
      flash[:warning] = "你不是本討論版成員，怎麼退出 XD"
    end
 
    redirect_to group_path(@group)
  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:title, :description)
    end
end
