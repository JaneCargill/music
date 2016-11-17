require('pg')
require_relative('../db/sql_runner')

class Song

  attr_accessor :song_title, :song_length, :album_id
  attr_accessor :id

  def initialize(options)
    @song_title = options['song_tite']
    @song_length = options['song_length'].to_i
    @album_id = options['album_id'].to_i
    @id = options['id'].to_i
  end


  def save()
    result = SqlRunner.run("INSERT INTO songs (song_title, song_length, album_id) VALUES ('#{@song_title}', '#{@song_length}', #{@album_id}) returning *;")
    @id = result[0]['id'].to_i
  end

  def update()
    SqlRunner.run("UPDATE songs SET (song_title, song_length, album_id) = ('#{@song_title}', '#{@song_length}', #{@album_id}) WHERE id = #{@id};")
  end

  def delete()
    SqlRunner.run("DELETE FROM songs WHERE id = #{@id};")
  end

  def album()
    results = SqlRunner.run("SELECT * FROM albums WHERE id = #{@album_id}")
    album = results.map {|hash| Album.new(hash)}
    return album
  end


  def self.all()
    songs = SqlRunner.run("SELECT * FROM songs;")
    return songs.map { |hash| Song.new(hash)}
  end

  def self.delete_all()
    SqlRunner.run("DELETE FROM songs;")
  end

end
