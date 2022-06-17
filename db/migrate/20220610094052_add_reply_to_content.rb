class AddReplyToContent < ActiveRecord::Migration[6.1]
  def change
    add_column :contacts, :reply, :text
    add_column :contacts, :replyed, :boolean, null:false, default:false
    add_column :contacts, :replyed_at, :datetime
  end
end
