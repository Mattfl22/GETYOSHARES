class AddBoughtToTokens < ActiveRecord::Migration[6.1]
  def change
    add_column :tokens, :bought, :boolean
  end
end
