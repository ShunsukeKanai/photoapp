class Post < ApplicationRecord
  mount_uploader :image, ImagesUploader
end
