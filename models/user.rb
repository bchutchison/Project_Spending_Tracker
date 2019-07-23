require_relative('../db/sql_runner')

class User

  attr_reader :id
  attr_accessor :budget, :name


    def initialize(options)
      @id = options['id'].to_i if options['id']
      @name = options['name']
      @budget = options['budget'].to_i
    end

    def save()
      sql = "INSERT INTO users
      (budget, name)
      VALUES
      ($1,$2)
      RETURNING id"
      values = [@budget, @name]
      user = SqlRunner.run( sql, values )
      @id = user.first()['id'].to_i
    end


    def self.delete_all()
      sql = "DELETE FROM users"
      SqlRunner.run( sql )
    end


    def self.delete(id)
      sql = "DELETE FROM users WHERE id = $1"
      values = [id]
      SqlRunner.run(sql, values)
    end


    def self.all()
      sql = "SELECT * FROM users"
      users = SqlRunner.run(sql)
      result = users.map{ |user|
      User.new(user)}
      return result
    end


    def self.find(id)
      sql = "SELECT * FROM users
      WHERE id = $1"
      values = [id]
      user = SqlRunner.run( sql, values )
      result = User.new( user.first )
      return result
    end

    def update()
      sql = "UPDATE users
      SET
      (budget, name)
      =
      ($1, $2)
      WHERE id = $3"
      values = [@budget, @name, @id]
      SqlRunner.run(sql, values)
    end

end
