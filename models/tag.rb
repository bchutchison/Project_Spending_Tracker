require_relative('../db/sql_runner')

class Tag

  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO tags
    (name)
    VALUES
    ($1)
    RETURNING id"
    values = [@name]
    tag = SqlRunner.run( sql, values )
    @id = tag.first()['id'].to_i
  end


  def self.delete_all()
    sql = "DELETE FROM tags"
    SqlRunner.run( sql )
  end


  def self.delete(id)
    sql = "DELETE FROM tags WHERE id = $1"
    values = [id]
    SqlRunner.run(sql, values)
  end


  def self.all()
    sql = "SELECT * FROM tags"
    tags = SqlRunner.run(sql)
    result = tags.map{ |tag|
    Tag.new(tag)}
    return result
  end


end
