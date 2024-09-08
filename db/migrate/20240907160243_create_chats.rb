class CreateChats < ActiveRecord::Migration[7.2]
  def change
    create_table :chats do |t|
      t.string :appToken
      t.integer :number
      t.integer :messageCount

      t.timestamps
    end
  end
end
