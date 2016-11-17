require('pry-byebug')
require_relative('models/artists')
require_relative('models/albums')
require_relative('models/song')

Song.delete_all()
Album.delete_all()
Artist.delete_all()


artist1 = Artist.new({
  'name' => 'Bon Jovi'
  })

artist2 = Artist.new({
  'name' => 'Oasis'
  })

artist3 = Artist.new({
  'name' => 'Ocean Colour'
  })

artist1.save()
artist2.save()
artist3.save()
artist3.name = 'Ocean Colour Scene'
artist3.update()


album1 = Album.new({
  'title' => 'Slippery When Wet',
  'genre' => 'Rock',
  'artist_id' => artist1.id
  })

album2 = Album.new({
  'title' => 'Crush',
  'genre' => 'Rock',
  'artist_id' => artist1.id
  })

album3 = Album.new({
  'title' => '(Whats the Story) Morning Glory?',
  'genre' => 'Rock',
  'artist_id' => artist2.id
  })

album4 = Album.new({
  'title' => 'Dont Believe the Truth',
  'genre' => 'Rock',
  'artist_id' => artist2.id
  })

album5 = Album.new({
  'title' => 'B-sides, Seasides and Freerides',
  'genre' => 'Rock',
  'artist_id' => artist3.id
  })

album1.save()
album2.save()
album3.save()
album4.save()
album5.save()
album5.delete()
artist3.delete()

album4.title = 'Definietly Maybe'
album4.update()

song1 = Song.new({
  'song_title' => 'Wonderwall',
  'song_length' => 3,
  'album_id' => album3.id
  })

song2 = Song.new({
  'song_title' => 'Dont Look Back in Anger',
  'song_length' => 4,
  'album_id' => album3.id
  })

song3 = Song.new({
  'song_title' => 'Champagne Supernova',
  'song_length' => 2,
  'album_id' => album3.id
  })

song1.save
song2.save
song3.save

artists = Artist.all()
albums = Album.all()
songs = Song.all()

binding.pry
nil