class Product < ApplicationRecord
  mount_uploaders :images, ProductUploader
  validates :images, presence: true
  validates :introduction, presence: true, length: { maximum: 500 }
  validates :name, presence: true, uniqueness: true, length: { maximum: 100 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 10000 }
  default_scope -> { order(created_at: :desc) }
end
