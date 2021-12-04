class MessageMailer < ApplicationMailer

    default from:'noreply@jokou.africa'

    def confirm_message_email
      @message = params[:message]
      @email = @message.chat.store.user.email
      mail(to: @email, subject:"Hi! You received a new message.")
    end
end
