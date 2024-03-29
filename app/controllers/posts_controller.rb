class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  # GET /posts or /posts.json
  def index
    @posts = Post.all.order("created_at DESC")
    @post = Post.new
  end

  # GET /posts/new
  def new
    @post = current_user.posts.build
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to root_path, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post = set_post
    @post.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

    # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :text)
  end
end
