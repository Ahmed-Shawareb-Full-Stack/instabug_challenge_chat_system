class MessagesController < ApplicationController
  before_action :set_chat
  before_action :set_message, only: [ :show, :update ]

  def index
    @messages = Message.where(chat_id: @chat.id)
    json_response(@messages.as_json(except: [ :id, :chat_id ]))
  end

  def show
    json_response(@message.as_json(except: [ :id, :chat_id ]))
  end

  def create
    # Increment message number in Redis
    @message_number = $redis.incr("#{params[:app_token]}-chat_number-#{params[:chat_number]}-message_number")

    MessageJob.perform_later(@chat.id, @message_number, message_params[:content])

    json_response({ number: @message_number }, :created)
  end

  def update
    @message.update!(message_params)
    json_response({ message: "Message (#{params[:number]}) updated successfully." })
  end

  def search
    query = query_params.fetch(:query) { raise ActionController::ParameterMissing, "query" }

    @messages = Message.search(@chat.id, query)
    json_response(@messages)
  end

  private

  def set_chat
    @chat = Chat.find_by!(appToken: params[:app_token], number: params[:chat_number])
  end

  def set_message
    @message = Message.find_by!(chat_id: @chat.id, number: params[:number])
  end

  def message_params
    params.permit(:content)
  end

  def query_params
    params.permit(:query)
  end
end
