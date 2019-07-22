require('sinatra')
require('sinatra/reloader')
require('pry-byebug')

require_relative('../models/transaction.rb')
require_relative('../models/tag.rb')
require_relative('../models/merchant.rb')
also_reload('../models/*')

#INDEX
get '/transactions' do
  @transactions = Transaction.all()
  @transactions_total = Transaction.total_transactions()
  @tag = Tag.all
  @merchant = Merchant.all
  erb(:"transactions/index")
end

#SORT INDEX
get '/transactions/sort/:dir' do
  @transactions = Transaction.sort_by_date(params['dir'])
  @transactions_total = Transaction.total_transactions()
  @tag = Tag.all
  @merchant = Merchant.all
  erb(:"transactions/sort")
end

#SORT MERCHANT
get '/transactions/sort-merchant/:merch' do
  @transactions = Transaction.sort_by_merchant(params['merch'])
  @transactions_total = Transaction.total_transactions()
  @tag = Tag.all
  @merchant = Merchant.all
  erb(:"transactions/sort_merchant")
end


#NEW
get '/transactions/new' do
  @tags = Tag.all
  @merchants = Merchant.all
  erb(:"transactions/new")
end

post '/transactions' do
  Transaction.new(params).save
  redirect to '/transactions'
end


#EDIT
get '/transactions/:id/edit' do
  @tags = Tag.all
  @merchants = Merchant.all
  @transactions = Transaction.find(params['id'])
  erb(:"transactions/edit")
end

post '/transactions/:id' do
  transaction = Transaction.new(params)
  transaction.update
  redirect to "/transactions/#{params['id']}"
end


#DELETE
post '/transactions/:id/delete' do
  Transaction.delete(params['id'])
  redirect to '/transactions'
end



#SHOW
get '/transactions/:id' do
  @transaction = Transaction.find(params['id'])
  @tag = Tag.all
  @merchant = Merchant.all
  erb(:"transactions/show")
end
