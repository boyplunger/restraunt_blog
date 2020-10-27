class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :check_role, only: [:edit, :update, :destroy]

  # GET /blogs
  # GET /blogs.json
  def index
    @q = Blog.ransack(params[:q])
    blogs = @q.result.includes(:user)
    blogs = blogs.tagged_with(params[:tag_list], any: true) if params[:tag_list].present?
    blogs = blogs.search_body(params[:body]) if params[:body].present?
    @blogs = blogs.page(params[:page]).per(5)
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = Blog.new(blog_params)

    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: I18n.t("notice.create") }
        format.json { render json: @blog, status: :created }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: I18n.t("notice.update") }
        format.json { render json: @blog, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: I18n.t("notice.delete") }
      format.json { head :no_content }
    end
  end

  def favorite
    @blog = Blog.includes(:favorites).find(params[:blog_id])
    @blog.has_favorites?(current_user) ? @blog.unlike(current_user.id) : @blog.like(current_user.id)
    render :favorite
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find_with_comments(params[:id])
    end

    def check_role
      redirect_to blogs_url unless @blog.user_id == current_user.id
    end

    # Only allow a list of trusted parameters through.
    def blog_params
      params.require(:blog).permit(:title, :body, :image, :image_cache, tag_list: []).merge({ user_id: current_user.id })
    end
end
