class AddChatTokenAndNumberIndex < ActiveRecord::Migration[7.2]
  def change
    add_index :chats, [ :appToken, :number ]
  end
end
