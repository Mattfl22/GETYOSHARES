class CreateSpotifyPlaylistService
  def initialize(user)
    @user = user
    RSpotify.authenticate("c6dd542512e445df990e7a7d889e636e", "ea5a0bb9078243e896ef58d3964cba48")
  end

  def call
    # spotify_user = RSpotify::User.find('112551945')

    spotify_user = RSpotify::User.new(
      {
        'credentials' => {
           "token" => self.credentials["BQCwC-MJSAlLdshi717gT4FDD9DFLIIQL0sPsxq8436A6lIYRvY3uZBH8zL7tWLj3K_Imt_rpe5qr5f1vNn1m1DvUQEDcdlERztw-zd7uAf7hKoo1QXpYxRgjfEDsWyDh77q0UhsCdIVyEO83L124CF5g5y79g"],
          #  "refresh_token" => self.credentials["refresh_token"],
          #  "access_refresh_callback" => callback_proc
        } ,
        'id' => self.credentials["user_id"]
      })


    my_playlists = spotify_user.playlists

    gys_playlist = my_playlists.find { |playlist| playlist.name == "Get-Yo-Shares" }

    if gys_playlist
      existing_playlist_spotify_track_ids = gys_playlist.tracks.map(&:id)
    else
      existing_playlist_spotify_track_ids = []
      gys_playlist = spotify_user.create_playlist!("Get-Yo-Shares")
    end

    @user.projects_as_investor.uniq.each do |project|
      track_urls = []

      project.tracks.each do |track|
        next if existing_playlist_spotify_track_ids.include?(track.spotify_id)

        track_urls << "https://open.spotify.com/track/#{track.spotify_id}"
      end

      gys_playlist.add_tracks!(track_urls)
    end
  end
end
