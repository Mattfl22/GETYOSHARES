class AddDefaultStateToCarts < ActiveRecord::Migration[6.1]
  def change
    change_column_default :carts, :state, from: nil, to: "pending"
  end
end
