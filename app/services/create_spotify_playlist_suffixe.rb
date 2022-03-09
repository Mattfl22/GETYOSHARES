class CreateSpotifyPlaylistService
  def initialize(user)
    @user = user
    RSpotify.authenticate("c6dd542512e445df990e7a7d889e636e", "ea5a0bb9078243e896ef58d3964cba48")
  end

  def call
    spotify_user = RSpotify::User.find('112551945')
    my_playlists = spotify_user.playlists
    if my_playlists.search("Get-Yo-Shares")
      gys_playlist = my_playlists.search("Get-Yo-Shares")
    else
      gys_playlist = spotify_user.create_playlist!("Get-Yo-Shares")
    end
    @user.projects_as_investor.uniq.each do |project|
      project.tracks.each do |track|
        spotify_track = RSpotify::Track.find(track.spotify_id)
        gys_playlist.add_tracks!(spotify_track) #if !gys_playlist.include?(spotify_track)
      end
    end
  end
end
