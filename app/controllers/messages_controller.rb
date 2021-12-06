class MessagesController < ApplicationController
  before_action :authenticate_user!
  def create
    chat = Chat.find(params[:chat_id])
    @store = Store.find(params[:store_id])
    message = chat.messages.build(message_params.merge(user: current_user))
      if message.save
        respond_to do |format|
          format.turbo_stream do
            MessageMailer.with(message:message).confirm_message_email.deliver_later
            render turbo_stream: turbo_stream.append(:messages, partial: "messages/message",
              locals: { message: message, user: current_user})
          end
          format.html { user_store_chat_path(current_user, @store, chat) }
        end
        # redirect_to user_store_chat_path(current_user, @store, chat)
      end
  end

  
  private 

  def message_params
    params.require(:message).permit(:content)
  end
end
