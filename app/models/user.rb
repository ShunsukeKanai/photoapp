class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :posts
  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true, uniqueness: { case_sensitive: true },
                   length: { maximum: 30 }
  validates :introduction, length: { maximum: 140 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: true }
end
