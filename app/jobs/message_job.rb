class MessageJob < ApplicationJob
  queue_as :default

  def perform(chat_id, message_number, content)
    @message = Message.new(chat_id: chat_id, number: message_number, content: content)
    @message.save!
  end
end
