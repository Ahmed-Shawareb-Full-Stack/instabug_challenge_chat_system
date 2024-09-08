class SetDefaultValueToChatCountAndMessageCount < ActiveRecord::Migration[7.2]
  def change
    change_column :apps, :chatCount, :integer, default: 0, null: false
    change_column :chats, :messageCount, :integer, default: 0, null: false
  end
end
