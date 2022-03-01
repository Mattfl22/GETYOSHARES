class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.string :comment
      t.integer :rating
      t.date :date
      t.boolean :active
      t.references :user, null: false, foreign_key: true
      t.references :token, null: false, foreign_key: true

      t.timestamps
    end
  end
end
