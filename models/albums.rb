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
    sql = "INSERT INTO albums(title, genre, artist_id) VALUES ('#{@title}', '#{genre}', #{artist_id}) returning *;"
    result = SqlRunner.run(sql)
    @id = result[0]['id'].to_i
  end

  def self.all()
    albums = SqlRunner.run("SELECT * FROM albums;")
    return albums.map { |hash| Album.new(hash)}
  end

  def self.delete_all()
    SqlRunner.run("DELETE FROM albums;")
  end


end