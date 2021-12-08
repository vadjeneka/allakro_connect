class MessageMailer < ApplicationMailer

    default from:'noreply@jokou.africa'

    def confirm_message_email
      @message = params[:message]
      @email = @message.chat.store.user.email
      @firstname = @message.chat.store.user
      mail(to: @email, subject:"Salut, vous avez reçu un nouveau message !")
    end
end
