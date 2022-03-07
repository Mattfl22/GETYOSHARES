class CreateCarts < ActiveRecord::Migration[6.1]
  def change
    create_table :carts do |t|
      t.string :checkout_session_id
      t.string :state
      t.timestamps
    end
  end
end
