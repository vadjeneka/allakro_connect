class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product

  def show 
    @comment = @product.comments
  end

  def create
    @comment = @product.comments.create(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to user_store_product_path(current_user, @product.store, @product), notice:'Votre avis à bien été envoyé'
    end
  end

  def edit
  end

  def update
    # @comment = Comment.find(params[:id])
    # if @comment.update(comment_params)
    
  end

  def destroy
    @comment = @product.comments.find(params[:id])
    @comment.destroy
    redirect_to user_store_product_path(@product), notice:'avis à bien été supprimé'
  end

  private 

  def comment_params
    params.require(:comment).permit(:comment)
  end

  def set_product
    @product = Product.find(params[:product_id])
  end
end
