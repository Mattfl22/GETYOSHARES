class CreateTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :tokens do |t|
      t.integer :unit_price
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
