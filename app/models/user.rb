class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/
  has_many :microposts, dependent: :destroy
  has_one :cart, dependent: :destroy
  validates :name, presence: true, length: { maximum: 15 }
  validates :password, presence: true, length: { in: 6..50, message: "6文字以上のパスワードを設定してください"}, on: :create
  validates :password_confirmation, presence: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX, multiline: true }, uniqueness: true
  attr_accessor :remember_token, :activation_token
  before_create :create_activation_digest
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

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
  
  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  def send_activation_mail
    UserMailer.acount_activation(self).deliver_now
  end

  private
    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end
