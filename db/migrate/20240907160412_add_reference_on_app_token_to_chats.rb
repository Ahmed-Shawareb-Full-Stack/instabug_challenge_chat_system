class AddReferenceOnAppTokenToChats < ActiveRecord::Migration[7.2]
  def change
    add_foreign_key :chats, :apps, column: :appToken, primary_key: "token"
  end
end
