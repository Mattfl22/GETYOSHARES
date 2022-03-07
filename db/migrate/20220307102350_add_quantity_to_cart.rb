class AddQuantityToCart < ActiveRecord::Migration[6.1]
  def change
    add_column :carts, :quantity, :integer
  end
end
