class Product < ApplicationRecord
  include Abyme::Model
  genres_list = [
    'African',
    'Alternative',
    'Ambient',
    'Relaxation',
    'Arabic',
    'Asian',
    'Blues',
    'Brazilian',
    'Children Music',
    'Christian & Gospel',
    'Classical',
    'Country',
    'House',
    'Dance',
    'Drum & Bass',
    'Electro',
    'Lounge',
    'Trance',
    'Techno',
    'Easy Listening',
    'Electronic',
    'Folk',
    'Hip Hop',
    'French Rap',
    'Rap UK',
    'Rap US',
    'Trap',
    'Indian',
    'Jazz',
    'Latin',
    'Metal',
    'Pop',
    'Pop - R&B',
    'Funk',
    'R&B/Soul',
    'Reggae',
    'Reggaeton',
    'Rock',
    'Metal',
    'Punk',
    'Hardcore',
    'Soundtrack',
    'Synth-pop',
    'World Music / Regional Folklore'
  ]

  belongs_to :project
  has_many :tracks, dependent: :destroy, inverse_of: :product
  abymize :tracks
  # validates :genre, inclusion: { in: genres_list, message: "it's not a valid genre" }
end
