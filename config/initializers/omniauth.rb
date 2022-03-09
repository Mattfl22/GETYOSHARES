require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, 'SPOTIFY_CLIENT_ID', 'SPOTIFY_CLIENT_SECRET', scope: 'playlist-modify-private playlist-read-collaborative playlist-read-private playlist-modify-public'
end
