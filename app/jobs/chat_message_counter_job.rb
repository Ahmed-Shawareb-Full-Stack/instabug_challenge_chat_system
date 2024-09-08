require "sidekiq-scheduler"

class ChatMessageCounterJob
  include Sidekiq::Worker

  def perform
    Chat.find_each do |chat|
      chat.messageCount = Message.where(chat_id: chat.id).length()
      chat.save!
    end
    puts "Chats Messages Counter Updated Successfully."
  end
end
