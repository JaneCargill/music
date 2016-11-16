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
end