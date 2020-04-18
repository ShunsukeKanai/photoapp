class Post < ApplicationRecord
  mount_uploader :image, ImagesUploader
  belongs_to :user

  validates :image, presence: true
  validates :description, presence: true, length: { maximum: 140 }

  def user
    return User.find_by(id: self.user_id)
  end

end
