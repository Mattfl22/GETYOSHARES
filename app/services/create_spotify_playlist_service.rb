class CreateSpotifyPlaylistService
  def initialize(user)
    @user = user
    # RSpotify.authenticate("c6dd542512e445df990e7a7d889e636e", "ea5a0bb9078243e896ef58d3964cba48")
  end

  def call
    spotify_user = RSpotify::User.new('id' => @user.uid, 'credentials' => { 'token' => @user.token })

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

      project.tracks.where.not(spotify_id: nil).each do |track|
        next if existing_playlist_spotify_track_ids.include?(track.spotify_id)

        track_urls << "spotify:track:#{track.spotify_id}"
      end

      next if track_urls.empty?

      gys_playlist.add_tracks!(track_urls)
    end
  end
end
