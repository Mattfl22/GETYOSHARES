class RemoveColumnFromTransactions < ActiveRecord::Migration[6.1]
  def change
    remove_column :transactions, :checkout_session_id
    remove_column :transactions, :date
    remove_column :transactions, :state
  end
end
