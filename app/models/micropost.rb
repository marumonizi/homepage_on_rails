class Micropost < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true 
  validates :title, presence: true, length:{maximum:100}
  validates :content, presence: true , length:{maximum:1000}
end
