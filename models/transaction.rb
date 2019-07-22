require_relative('../db/sql_runner')
require_relative('./tag.rb')
require_relative('./merchant.rb')

class Transaction

  attr_reader :id
  attr_accessor :tag_id, :merchant_id, :value, :details, :order_date

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @tag_id = options['tag_id'].to_i
    @merchant_id = options['merchant_id'].to_i
    @value = options['value'].to_i
    @details = options['details']
    @order_date = options ['order_date']
  end

#CREATE
  def save()
    sql = "INSERT INTO transactions
    (tag_id, merchant_id, value, details, order_date)
    VALUES
    ($1,$2,$3,$4,$5)
    RETURNING id"
    values = [@tag_id, @merchant_id, @value, @details, @order_date]
    transaction = SqlRunner.run( sql, values )
    @id = transaction.first()['id'].to_i
  end

#DELETE
  def self.delete_all()
    sql = "DELETE FROM transactions"
    SqlRunner.run( sql )
  end

#DELETE
  def self.delete(id)
    sql = "DELETE FROM transactions WHERE id = $1"
    values = [id]
    SqlRunner.run(sql, values)
  end

#READ
  def self.all()
    sql = "SELECT * FROM transactions"
    transactions = SqlRunner.run(sql)
    result = transactions.map{ |transaction| Transaction.new(transaction)}
    return result
  end

#UPDATE
  def self.find(id)
    sql = "SELECT * FROM transactions
    WHERE id = $1"
    values = [id]
    transaction = SqlRunner.run( sql, values )
    result = Transaction.new( transaction.first )
    return result
  end

  def tag
    sql = "SELECT * FROM tags
    WHERE id = $1"
    values = [@tag_id]
    tag = SqlRunner.run( sql, values ).first
    return Tag.new(tag)
  end

  def merchant
    sql = "SELECT * FROM merchants
    WHERE id = $1"
    values = [@merchant_id]
    merchant = SqlRunner.run( sql, values ).first
    return Merchant.new(merchant)
  end

  def update()
    sql = "UPDATE transactions
    SET
    (tag_id,
    merchant_id,
    value,
    details)
    =
    ($1, $2, $3, $4, $5)
    WHERE id = $6"
    values = [@tag_id, @merchant_id, @value, @details, @order_date, @id]
    SqlRunner.run(sql, values)
  end


  def self.total_transactions
    array = self.all()
    total = 0
    array.map{|price| total += price.value}
    return total
  end

def self.sort_by_date(direction = 'ASC')
  sql = "SELECT * FROM transactions
  ORDER BY order_date #{direction}"
  transactions = SqlRunner.run(sql)
  result = transactions.map{ |transaction| Transaction.new(transaction)}
  return result
end



end
