class ChangedatatypeImagesToProduct < ActiveRecord::Migration[6.1]
  def change
    change_column :products, :images, :json
  end
end
