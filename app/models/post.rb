class Post < ApplicationRecord
  validates :image, presence: true
  validates :description, presence: true
  mount_uploader :image, ImagesUploader
  belongs_to :user

  def photo
    return self.image.variant(resize: '50x50')
  end

  def user
    return User.find_by(id: self.user_id)
  end

end
