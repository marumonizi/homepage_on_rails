class User < ApplicationRecord
  has_many :microposts
  attr_accessor :remember_token
  validates :name, presence: true, length: { maximum: 15 }, uniqueness: true
  validates :password, presence: true, length: { in: 6..50, message: "6文字以上のパスワードを設定してください。"}, on: :create
  validates :password_confirmation, presence: true
  has_secure_password

  # ランダムなトークンを返す
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # 永続的セッションで使用するユーザーをDBに保存する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
