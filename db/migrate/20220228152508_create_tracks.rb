class CreateTracks < ActiveRecord::Migration[6.1]
  def change
    create_table :tracks do |t|
      t.string :isrc
      t.string :grid
      t.string :title
      t.string :featuring
      t.string :spotify_id
      t.string :youtube_id
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
