require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('controllers/merchant_controller')
require_relative('controllers/tag_controller')
require_relative('controllers/tracker_controller')
require_relative('./models/user.rb')
require_relative('./models/transaction.rb')




#INDEX
get '/' do
  @transactions = Transaction.all()
  @transactions_total = Transaction.total_transactions()
  @user = User.all[0]
  erb(:index)
end

#EDIT BUDGET
get '/:id/new-budget' do
  @transactions_total = Transaction.total_transactions()
  @user = User.all[0]
  erb(:new_budget)
end

post '/:id' do
  @user = User.all[0]
  budget = User.new(params)
  budget.update
  redirect to '/'
end
