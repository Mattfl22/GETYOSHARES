class AddStateColumnToCart < ActiveRecord::Migration[6.1]
  def change
    add_column :cart, :state
  end
end
