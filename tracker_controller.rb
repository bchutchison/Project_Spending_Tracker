require('sinatra')
require('sinatra/reloader')
require('pry-byebug')

require_relative('./models/transaction.rb')
require_relative('./models/tag.rb')
require_relative('./models/merchant.rb')
also_reload('./models/*')

#INDEX
get '/transactions' do
  @transactions = Transaction.all()
  erb(:index)
end

#SHOW
get '/transactions/:id' do
  @transaction = Transaction.find(params[:id])
  erb(:show)
end
