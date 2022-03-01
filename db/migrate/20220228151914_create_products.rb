class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.integer :upc
      t.string :grid
      t.string :title
      t.string :language
      t.string :format
      t.string :genre
      t.string :spotify_id
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
