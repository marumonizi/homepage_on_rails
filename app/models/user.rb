class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 15 }, uniqueness: true
  validates :password, presence: true, length: { in: 6..10, wrong_length: "6文字以上10文字以内のパスワードを設定してください。"}, on: :create
  has_secure_password

  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
