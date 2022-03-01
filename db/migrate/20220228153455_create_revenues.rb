class CreateRevenues < ActiveRecord::Migration[6.1]
  def change
    create_table :revenues do |t|
      t.date :date
      t.float :revenue
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
