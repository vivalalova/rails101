class PostsController < ApplicationController
  # before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :find_group
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new

      @post = @group.posts.new
  end

  # GET /posts/1/edit
  def edit

      @post = @group.posts.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create

   @post = @group.posts.build(post_params)

   if @post.save
     redirect_to group_path(@group), notice: "新增文章成功！"
   else
     render :new
   end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update

   @post = @group.posts.find(params[:id])

   if @post.update(post_params)
     redirect_to group_path(@group), notice: "文章修改成功！"
   else
     render :edit
   end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy

   @post = @group.posts.find(params[:id])

   @post.destroy
   redirect_to group_path(@group), alert: "文章已刪除"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def find_group
      @group = Group.find(params[:group_id])
    end  

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:content, :group_id)
    end
end
