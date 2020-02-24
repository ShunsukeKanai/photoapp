class Post < ApplicationRecord
  mount_uploader :image, ImagesUploader

  def photo
    return self.image.variant(resize: '50x50')
  end

end
