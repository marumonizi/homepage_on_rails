class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  with_options presence: true do
    validates :product_id
    validates :cart_id
    validates :quantity, numericality: { greater_than: 0 }
  end
  default_scope -> { order(created_at: :desc) }

  def sum_of_price
    product.price.to_i * quantity
  end
end
