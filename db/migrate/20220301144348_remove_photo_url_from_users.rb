class RemovePhotoUrlFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :photo_url, :string
  end
end
