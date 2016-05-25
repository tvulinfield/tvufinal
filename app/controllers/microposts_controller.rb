class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  #def index
    #@micropost = Micropost.all.order("created_at DESC")
  #end
  #def index
    #@microposts = Micropost.all
    #@comment = @micropost.comments.build(params[:comment])
    #@comment.user = current_user
  #end
  def index
    if !params[:q].nil? and !params[:q].empty?
      @micropost = Micropost.where(:user_id => User.find_by_name(params[:q]))
    else
      @micropost = Micropost.all
    end
  end

  def show
   
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Post created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
  	@micropost.destroy
    flash[:success] = "Post deleted"
    redirect_to request.referrer || root_url
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end