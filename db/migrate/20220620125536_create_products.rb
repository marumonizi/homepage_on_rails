class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :price
      t.json :images
      t.text :introduction
      t.timestamps
    end
  end
end
