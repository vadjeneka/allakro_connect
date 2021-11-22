class MessagesController < ApplicationController
  before_action :authenticate_user!
  def create
    # raise params.inspect
    chat = Chat.find(params[:chat_id])
    message = chat.messages.build(message_params.merge(user: current_user))
      if message.save
        redirect_to user_chat_path(current_user, chat), notice:  'message was successfully created'
      else
        raise message.errors.inspect
      end
  end

  
  private 

  def message_params
    params.require(:message).permit(:content)
  end
end
