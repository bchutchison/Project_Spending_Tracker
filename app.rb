require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('controllers/merchant_controller')
require_relative('controllers/tag_controller')
require_relative('controllers/tracker_controller')



#INDEX
get '/' do
  @transactions = Transaction.all()
  @transactions_total = Transaction.total_transactions()
  @tag = Tag.all
  @merchant = Merchant.all
  erb(:index)
end
