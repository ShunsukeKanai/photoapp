class ChangePostsDescriptionNotNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :posts, :description, false
    change_column_null :posts, :image, false
  end
end
