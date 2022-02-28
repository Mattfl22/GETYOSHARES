class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :artist_name, :string
    add_column :users, :country, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :photo_url, :string
  end
end
