class CommentsController < ApplicationController
	#before_filter :signed_in_user, only: [:create, :destroy]
	def create
		@micropost = Micropost.find(params[:micropost_id])
		#@comment = Comment.new(params[:comment])
		#@comment.micropost = @micropost
    	
    	#@comment.user = current_user
		@comment = @micropost.comments.create(comment_params)
		@comment.user_id = current_user.id

		if @comment.save
			flash[:success] = "Comment posted"
			redirect_to micropost_path(@micropost)
			#redirect_to current_user
		else
			render 'new'
		end
	end

	private

	def comment_params
		params.require(:comment).permit(:content)
	end
end
