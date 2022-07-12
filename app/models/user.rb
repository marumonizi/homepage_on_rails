class User < ApplicationRecord
  has_many :microposts, dependent: :destroy
  has_one :cart, dependent: :destroy
  attr_accessor :remember_token
  validates :name, presence: true, length: { maximum: 15 }, uniqueness: true
  validates :password, presence: true, length: { in: 6..50, message: "6文字以上のパスワードを設定してください"}, on: :create
  validates :password_confirmation, presence: true
  has_secure_password

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
