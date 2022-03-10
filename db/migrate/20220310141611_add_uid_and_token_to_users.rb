class AddUidAndTokenToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :uid, :string
    add_column :users, :token, :string
  end
end
