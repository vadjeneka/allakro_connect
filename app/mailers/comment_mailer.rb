class CommentMailer < ApplicationMailer
  default from:'noreply@jokou.africa'

  def confirm_comment_email
    @comment = params[:comment]
    @email = @comment.product.store.user.email
    mail(to: @email, subject:"Salut, vous avez reçu un nouveau commentaire !")
  end
end
