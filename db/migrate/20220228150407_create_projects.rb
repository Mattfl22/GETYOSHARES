class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.references :user, null: false, foreign_key: true
      t.string :distributor
      t.string :name
      t.string :description
      t.date :release_date
      t.integer :average_distribution_share
      t.integer :expected_audio_streams_year
      t.integer :expected_video_streams_year
      t.integer :number_of_tokens

      t.timestamps
    end
  end
end
