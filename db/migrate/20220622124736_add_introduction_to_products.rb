class AddIntroductionToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :introduction, :text
  end
end
