class CreateEventNotices < ActiveRecord::Migration[5.2]
  def change
    create_table :event_notices do |t|
      t.integer :group_id
      t.integer :user_id
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
