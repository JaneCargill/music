require('pg')
require_relative('../db/sql_runner')

class Album

  attr_accessor :title, :genre, :artist_id
  attr_reader :id

  def initialize(options)
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO albums(title, genre, artist_id) VALUES ('#{@title}', '#{@genre}', #{@artist_id}) returning *;"
    result = SqlRunner.run(sql)
    @id = result[0]['id'].to_i
  end

  def update()
    SqlRunner.run("UPDATE albums SET (title, genre, artist_id) = ('#{@title}', '#{@genre}', #{@artist_id}) WHERE id = #{id};")
  end

  def delete()
    SqlRunner.run("DELETE FROM albums WHERE id = #{@id};")
  end

  def artist()
    result = SqlRunner.run("SELECT * FROM artists WHERE id = #{@artist_id};")
    artist = Artist.new(result[0])
    return artist
  end

  def songs()
    results = SqlRunner.run("SELECT * FROM songs WHERE album_id = #{@id};")
    return results.map {|hash| Song.new(hash)}
  end

  def total_length()
    result = SqlRunner.run("SELECT SUM(song_length) FROM songs WHERE album_id = #{@id};")
    songs = Song.new(result[0])
    return songs
  end

  def self.all()
    albums = SqlRunner.run("SELECT * FROM albums;")
    return albums.map { |hash| Album.new(hash)}
  end

  def self.delete_all()
    SqlRunner.run("DELETE FROM albums;")
  end
end