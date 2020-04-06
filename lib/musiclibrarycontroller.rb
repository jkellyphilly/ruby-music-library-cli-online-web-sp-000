class MusicLibraryController

  @@numbered_list_all_songs = []

  def initialize(path = "./db/mp3s")
    music_importer = MusicImporter.new(path)
    music_importer.import
  end

  # Welcomes the user and gives the user a list of options
  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    user_input = ""

    # Until the user puts "exit", keep asking them for what they'd like to do
    while user_input != "exit"
      puts "What would you like to do?"
      user_input = gets
    end
  end

  def list_songs
    counter = 1
    sorted_songs = Song.all.sort_by {|song| song.name}
    sorted_songs.each do |song|
      puts "#{counter}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
      @@numbered_list_all_songs << song
      counter += 1
    end
  end

  def list_artists
    counter = 1
    sorted_artists = Artist.all.sort_by {|artist| artist.name}
    sorted_artists.each do |artist|
      puts "#{counter}. #{artist.name}"
      counter += 1
    end
  end

  def list_genres
    counter = 1
    sorted_genres = Genre.all.sort_by {|genre| genre.name}
    sorted_genres.each do |genre|
      puts "#{counter}. #{genre.name}"
      counter += 1
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    user_artist = gets.strip
    artist = Artist.find_by_name(user_artist)
    if artist != nil
      counter = 1
      sorted_songs = artist.songs.sort_by {|song| song.name}
      sorted_songs.each do |song|
        puts "#{counter}. #{song.name} - #{song.genre.name}"
        counter += 1
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    user_genre = gets.strip
    genre = Genre.find_by_name(user_genre)
    if genre != nil
      counter = 1
      sorted_songs = genre.songs.sort_by {|song| song.name}
      sorted_songs.each do |song|
        puts "#{counter}. #{song.artist.name} - #{song.name}"
        counter += 1
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    user_input = gets.strip.to_i
    binding.pry
    if user_input < 1 || user_input > @@numbered_list_all_songs.size
      puts "Not a valid input. Please enter a number from 1 to #{@@numbered_list_all_songs.size}"
    else
      puts "Playing #{@@numbered_list_all_songs[user_input - 1].name} by #{@@numbered_list_all_songs[user_input - 1].artist.name}"
    end
    #binding.pry
  end

end
