require('sinatra')
require('sinatra/reloader')
require('pry-byebug')
require('pi_charts')

require_relative('../models/transaction.rb')
require_relative('../models/tag.rb')
require_relative('../models/merchant.rb')
also_reload('../models/*')


#refactor 4 pages below inot one page
#INDEX
get '/transactions' do
  @transactions = Transaction.all()
  @transactions_total = Transaction.total_transactions()
  @tag = Tag.all
  @merchant = Merchant.all
  @user = User.all[0]
  erb(:"transactions/index")
end


#SORT INDEX
get '/transactions/sort/:dir' do
  @transactions = Transaction.sort_by_date(params['dir'])
  @transactions_total = Transaction.total_transactions()
  @tag = Tag.all
  @merchant = Merchant.all
  @user = User.all[0]
  erb(:"transactions/sort")
end

#SORT MERCHANT
get '/transactions/sort-merchant/:merch' do
  @transactions = Transaction.sort_by_merchant(params['merch'])
  @transactions_total = Transaction.total_transactions()
  @tag = Tag.all
  @merchant = Merchant.all
  @user = User.all[0]
  erb(:"transactions/sort_merchant")
end

#SORT TAG
get '/transactions/sort-tag/:category' do
  @transactions = Transaction.sort_by_tag(params['category'])
  @transactions_total = Transaction.total_transactions()
  @tag = Tag.all
  @merchant = Merchant.all
  @user = User.all[0]
  erb(:"transactions/sort_tag")
end


#NEW
get '/transactions/new' do
  @tags = Tag.all
  @merchants = Merchant.all
  @transactions_total = Transaction.total_transactions()
  @user = User.all[0]
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



# Please note that this 'may be' (definitely is) illegal code according to the brief. Uses require('pi_charts') explained at https://medium.com/@KentGruber/picharts-easy-javascript-charts-with-ruby-e39e0b34332a

get('/pie_merchant') { Transaction.total_value_by_merchant_pie_chart() }
get('/pie_tag') { Transaction.total_value_by_tag_pie_chart() }
