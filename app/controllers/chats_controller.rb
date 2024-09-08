class ChatsController < ApplicationController
  before_action :set_app, only: [ :create ]
  before_action :set_chat, only: [ :show ]

  def index
    @chats = Chat.where(appToken: params[:app_token])
    json_response(@chats.as_json(except: [ :id ]))
  end

  def show
    json_response(@chat.as_json(except: [ :id ]))
  end

  def create
    @chat_number = $redis.incr("#{params[:app_token]}-chat_number")

    ChatJob.perform_later(params[:app_token], @chat_number)

    json_response({ number: @chat_number }, :created)
  end

  private

  def set_app
    @app = App.find_by!(token: params[:app_token])
  end

  def set_chat
    @chat = Chat.find_by!(appToken: params[:app_token], number: params[:number])
  end
end
