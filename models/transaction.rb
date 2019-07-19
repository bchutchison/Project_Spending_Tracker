require_relative('../db/sql_runner')
require_relative('./tag.rb')
require_relative('./merchant.rb')

class Transaction

  attr_reader :id
  attr_accessor :tag_id, :merchant_id, :value

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @tag_id = options['tag_id'].to_i
    @merchant_id = options['merchant_id'].to_i
    @value = options['value'].to_i
  end

  def save()
    sql = "INSERT INTO transactions
    (tag_id, merchant_id, value)
    VALUES
    ($1,$2,$3)
    RETURNING id"
    values = [@tag_id, @merchant_id, @value]
    transaction = SqlRunner.run( sql, values )
    @id = transaction.first()['id'].to_i
  end


  def self.delete_all()
    sql = "DELETE FROM transactions"
    SqlRunner.run( sql )
  end

end
