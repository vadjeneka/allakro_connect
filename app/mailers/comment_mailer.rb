class CommentMailer < ApplicationMailer
  default from:'noreply@jokou.africa'

  def confirm_comment_email
    @comment = params[:comment]
    @email = @comment.product.store.user.email
    mail(to: @email, subject:"Hi! You received a new comment.")
  end
end
