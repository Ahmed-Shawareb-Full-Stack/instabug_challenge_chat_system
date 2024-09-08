require "sidekiq-scheduler"

class AppChatCounterJob
  include Sidekiq::Worker

  def perform
    App.find_each do |app|
      app.chatCount = Chat.where(appToken: app.token).length()
      app.save!
    end
    puts "Application Chats Counter Updated Successfully."
  end
end
