class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.string :comment
      t.date :date
      t.integer :rating
      t.boolean :active
      t.references :user, null: false, foreign_key: true
      t.references :token, null: false, foreign_key: true
      t.string :state
      t.string :token_sku
      t.monetize :amount, currency: { present: false }
      t.string :checkout_session_id

      t.timestamps
    end
  end
end
