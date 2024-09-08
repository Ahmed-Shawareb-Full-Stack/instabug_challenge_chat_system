class ChatJob < ApplicationJob
  queue_as :default

  def perform(app_token, chat_number)
    @chat = Chat.new(appToken: app_token, number: chat_number)
    @chat.save!
  end
end
