class Contact < ApplicationRecord
  validates :name, presence: true, on: :create
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX, multiline: true }, on: :create
  validates :message, presence: true, length: {maximum: 1000}, on: :create
  validates :reply, presence: true, length: {maximum: 1000}, on: :update
  validates :category, presence: { message: "選択してください" }, length: {maximum: 100}, on: :create
  default_scope -> { order(created_at: :desc) }
end