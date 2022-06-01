class AddImageToMicroposts < ActiveRecord::Migration[6.1]
  def change
    add_column :microposts, :image, :string
  end
end
