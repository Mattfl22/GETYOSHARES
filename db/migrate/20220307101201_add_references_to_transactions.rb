class AddReferencesToTransactions < ActiveRecord::Migration[6.1]
  def change
    add_reference :transactions, :cart, foreign_key: true
  end
end
