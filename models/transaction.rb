require_relative('../db/sql_runner')
require_relative('./tag.rb')
require_relative('./merchant.rb')
require('pi_charts')

class Transaction

  attr_reader :id
  attr_accessor :tag_id, :merchant_id, :value, :details, :order_date, :receipt

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @tag_id = options['tag_id'].to_i
    @merchant_id = options['merchant_id'].to_i
    @value = options['value'].to_i
    @details = options['details']
    @order_date = options ['order_date']
    @receipt = options ['receipt']
  end

#CREATE
  def save()
    sql = "INSERT INTO transactions
    (tag_id, merchant_id, value, details, order_date, receipt)
    VALUES
    ($1,$2,$3,$4,$5,$6)
    RETURNING id"
    values = [@tag_id, @merchant_id, @value, @details, @order_date, @receipt]
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
    details,
    order_date,
    receipt)
    =
    ($1, $2, $3, $4, $5, $6)
    WHERE id = $7"
    values = [@tag_id, @merchant_id, @value, @details, @order_date, @receipt, @id]
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

  def self.sort_by_merchant(merchant)
    sql = "SELECT * FROM transactions
    INNER JOIN merchants
    ON merchants.id = transactions.merchant_id
    WHERE merchants.name = $1"
    values = [merchant]
    transactions = SqlRunner.run(sql, values)
    result = transactions.map{ |transaction| Transaction.new(transaction)}
    return result
  end

  def self.sort_by_tag(tag)
    sql = "SELECT * FROM transactions
    INNER JOIN tags
    ON tags.id = transactions.tag_id
    WHERE tags.name = $1"
    values = [tag]
    transactions = SqlRunner.run(sql, values)
    result = transactions.map{ |transaction| Transaction.new(transaction)}
    return result
  end




#Please note that this 'may be' (definitely is) illegal code according to the brief. Uses require('pi_charts') explained at https://medium.com/@KentGruber/picharts-easy-javascript-charts-with-ruby-e39e0b34332a

  def self.total_value_by_merchant_pie_chart()
    chart = PiCharts::Pie.new
    merchants = Merchant.all()
    for merchant in merchants
      chart.add_dataset(label: merchant.name, data: merchant.total_spending())
    end
    chart.hover
    chart.responsive
    "<head>" + chart.cdn + "</head>" + "<body>" + chart.html(width: 60) + "</body>"
  end

  def self.total_value_by_tag_pie_chart()
    chart = PiCharts::Pie.new
    tags = Tag.all()
    for tag in tags
      chart.add_dataset(label: tag.name, data: tag.total_spending())
    end
    chart.hover
    chart.responsive
    "<head>" + chart.cdn + "</head>" + "<body>" + chart.html(width: 60) + "</body>"
  end







end
