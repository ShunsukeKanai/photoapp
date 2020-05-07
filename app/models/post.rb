class Post < ApplicationRecord
  mount_uploader :image, ImagesUploader
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :image, presence: true
  validates :description, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true

  def user
    return User.find_by(id: self.user_id)
  end

end
