class AddStateToCart < ActiveRecord::Migration[6.1]
  def change
    add_column :carts, :state, :string
  end
end
