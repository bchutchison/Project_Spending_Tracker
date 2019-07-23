require_relative('../db/sql_runner')

class Merchant

  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end


  def save()
    sql = "INSERT INTO merchants
    (name)
    VALUES
    ($1)
    RETURNING id"
    values = [@name]
    merchant = SqlRunner.run( sql, values )
    @id = merchant.first()['id'].to_i
  end


  def self.delete_all()
    sql = "DELETE FROM merchants"
    SqlRunner.run( sql )
  end


  def self.delete(id)
    sql = "DELETE FROM merchants WHERE id = $1"
    values = [id]
    SqlRunner.run(sql, values)
  end


  def self.all()
    sql = "SELECT * FROM merchants"
    merchants = SqlRunner.run(sql)
    result = merchants.map{ |merchant| Merchant.new(merchant)}
    return result
  end


  def self.find(id)
    sql = "SELECT * FROM merchants
    WHERE id = $1"
    values = [id]
    merchant = SqlRunner.run( sql, values )
    result = Merchant.new( merchant.first )
    return result
  end

  def update()
    sql = "UPDATE merchants
    SET
    name
    =
    $1
    WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def total_spending()
  # create method for finding total transaction value in sql
    sql = "SELECT SUM(value)
    FROM transactions
    WHERE merchant_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values).first()['sum'].to_i
    return result
  end


end
