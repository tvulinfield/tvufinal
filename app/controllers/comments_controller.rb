class CommentsController < ApplicationController
	#before_filter :signed_in_user, only: [:create, :destroy]
	before_action :logged_in_user, only: [:create, :destroy]
  	before_action :correct_user,   only: :destroy
	def create
		@micropost = Micropost.find(params[:micropost_id])
		#@comment = Comment.new(params[:comment])
		#@comment.micropost = @micropost
    	
    	#@comment.user = current_user
		@comment = @micropost.comments.create(comment_params)
		@comment.user_id = current_user.id

		if @comment.save
			flash[:success] = "Comment posted"
			#redirect_to micropost_path(@micropost)
			redirect_to root_url
		else
			redirect_to root_url
		end
	end

	def index
    	@comments = Comment.all
  	end

	def destroy
		
		#@comment = @micropost.comments.find(params[:id])
		#@comment.destroy
		#redirect_to micropost_path(@micropost)
		@micropost = Micropost.find(params[:micropost_id])
    	@comment = @micropost.comments.find(params[:id])
    	@comment.destroy
    	redirect_to request.referrer || root_url
	end
	

	def new
		@comment = Comment.new
	end

	def show
    	@comment = Comment.find(params[:id])
  	end

	private

	def comment_params
		params.require(:comment).permit(:content)
	end

    def correct_user
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_to root_url if @comment.nil?
    end

end
