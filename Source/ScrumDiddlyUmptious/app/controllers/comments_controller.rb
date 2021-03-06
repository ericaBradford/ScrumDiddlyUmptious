class CommentsController < ApplicationController

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = @recipe.comments.create(comment_params)
    redirect_to recipe_path(@recipe)
  end

  def findCommenter
    @comment = Comments.find(params[:id])
    @commenter = User.find(@comment.id_Users)
  end

 private
  def comment_params
    params.require(:comment).permit(:commenter, :comment)
  end
end
