class RemoveMessagesIndexMessagesOnChatId < ActiveRecord::Migration[7.2]
  def change
    remove_index :messages, name: "index_messages_on_chat_id"
  end
end
