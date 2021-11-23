class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat, only:[:show, :edit, :update, :destroy]

  def index
    # @chats = Chat.all
    @users = User.all_expect(current_user)
  end

  def show
    # raise params.inspect
    chat = Chat.find(params[:id])
    @message = Message.includes(:user).where(chat_id: chat.id)
    @chat = set_chat
    # @guest = User.find(chat.receiver_id)
    @messages = Message.new
  end

  def new
    @chat = Chat.new
    @guest = User.find(params[:guest])

    exist_chat = nil
    user_chat = Chat.where("user_id = ? OR receiver_id = ?", "#{current_user.id}","#{current_user.id}")
    user_chat.each do |chat|
      if (chat.receiver_id == @guest.id && chat.user_id == current_user.id) || (chat.receiver_id == current_user.id && chat.user_id == @guest.id)
        exist_chat = chat
      end
    end

    if exist_chat
      redirect_to user_chat_path(current_user, exist_chat)
    end
  end

  def edit
  end

  def create
    # raise params[:chat][:guest].inspect
    guest = User.find(params[:chat][:guest])
    # raise Chat.new.inspect
    @chat = current_user.chats.build({name: guest.email}.merge(receiver_id: guest.id))
    # raise @chat.inspect
    if @chat.save
      message = @chat.messages.build(chat_params.merge(user: current_user))
      if message.save
        redirect_to user_chat_path(current_user, @chat), notice:  'Chat was successfully created'
      else
        raise message.errors.inspect
      end
    else
      raise @chat.errors.inspect
      flash[:error]= 'error'
      render 'new'
    end
  end

  def update
    @chat = Chat.find(params[:id])
    if @chat.update(chat_params)
      redirect_to user_chats_path(@current_user)
    else
      flash[:error] = 'error'
      render 'edit'
    end
  end

  def destroy 
    @chat = Chat.find(params[:id])
    @chat.destroy
    redirect_to user_chats_path(@current_user)
  end

  private 

  def set_chat
    @chat = Chat.find(params[:id])
  end

  def chat_params
    params.require(:chat).permit(:content)
  end

end
