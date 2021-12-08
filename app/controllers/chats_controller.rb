class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat, only:[:show, :edit, :update, :destroy]
  before_action :chats_list, only: [:index, :show, :new]
  def index
    if current_user
      if current_user.first_name == nil && current_user.town == nil && current_user.city == nil
        redirect_to edit_profile_path(current_user)
      end 
    end
    # @chats = Chat.all
    # @users = User.all_expect(current_user)
    @chat_from_store = current_user.store.chats if current_user.store
    @chat_from_me = current_user.chats
  end

  def show
    chat = Chat.find(params[:id])
    @message = Message.includes(:user).where(chat_id: chat.id)
    @chat = set_chat
    # @store = User.find(chat.store_id)
    @messages = Message.new
    @store = Store.find(params[:store_id])

    notifs = Notification.where(user_id: current_user.id, chat_id:@chat.id)
    if notifs.where(read_at: false)
      notifs.update(read_at: true)
    end

  end

  def new
    @chat = Chat.new
    @store = Store.find(params[:store_id])

    exist_chat = nil
    user_chat = Chat.where(store_id: @store.id)
    user_chat.each do |chat|
      if (chat.store_id == @store.id && chat.user_id == current_user.id)
        exist_chat = chat
      end
    end

    if exist_chat
      redirect_to store_chat_path(@store, exist_chat)
    end
  end

  def edit
  end

  def create
    @store = Store.find(params[:store_id])
    @chat = current_user.chats.build({name: @store.name}.merge(store_id: @store.id))
    if @chat.save
      message = @chat.messages.build(chat_params.merge(user: current_user))
      if message.save
        redirect_to store_chat_path(@store, @chat)
      else
        raise message.errors.inspect
      end
    else
      raise @chat.errors.inspect
      flash[:error]= 'erreur!'
      render 'new'
    end
  end

  def update
    @chat = Chat.find(params[:id])
    @store = Store.find(params[:store_id])
    if @chat.update(chat_params)
      redirect_to user_store_chats_path(@current_user, @store, @chat)
    else
      flash[:error] = 'erreur!'
      render 'edit'
    end
  end

  def destroy 
    @chat = Chat.find(params[:id])
    @store = Store.find(params[:store_id])
    @chat.destroy
    redirect_to user_store_chats_path(@current_user, @store, @chat)
  end

  private 

  def set_chat
    @chat = Chat.find(params[:id])
  end

  def chat_params
    params.require(:chat).permit(:content)
  end

  def chats_list
    @chat_from_store = current_user.store.chats if current_user.store
    @chat_from_me = current_user.chats
  end

end
