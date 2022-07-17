class AddActivationToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :email, :string, null: false
    add_index :users, :email, unique: true
    add_column :users, :activation_digest, :string
    add_column :users, :activated, :boolean, default: false
    add_column :users, :activated_at, :datetime
  end
end
