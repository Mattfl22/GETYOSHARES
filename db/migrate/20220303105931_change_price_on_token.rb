class ChangePriceOnToken < ActiveRecord::Migration[6.1]
  def change
    remove_column :tokens, :unit_price
    add_monetize :tokens, :price, currency: { present: false }
  end
end
