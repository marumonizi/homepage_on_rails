class AddCategoryToContact < ActiveRecord::Migration[6.1]
  def change
    add_column :contacts, :category, :string
  end
end
