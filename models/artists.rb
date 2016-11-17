require('pg')
require_relative('../db/sql_runner')

class Artist

  attr_accessor :name
  attr_reader :id

  def initialize(options)
    @name = options['name']
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO artists(name) VALUES ('#{@name}') returning *;"
    result = SqlRunner.run(sql)
    @id = result[0]['id'].to_i
  end

  def update()
    SqlRunner.run("UPDATE artists SET (name) = ('#{@name}') WHERE id = #{@id};")
  end

  def delete()
    SqlRunner.run("DELETE FROM artists WHERE id = #{@id};")
  end

  def albums()
    results = SqlRunner.run("SELECT * FROM albums WHERE artist_id = #{@id};")
    albums = results.map {|hash| Album.new(hash)}
    return albums
  end


  def self.all()
    artists = SqlRunner.run("SELECT * FROM artists;")
    return artists.map { |hash| Artist.new(hash)}
  end

  def self.delete_all()
    SqlRunner.run("DELETE FROM artists;")
  end

end