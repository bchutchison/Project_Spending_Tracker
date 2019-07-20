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
  @tag = Tag.all
  @merchant = Merchant.all
  erb(:index)
end


#NEW
get '/transactions/new' do
  @tags = Tag.all
  @merchants = Merchant.all
  erb(:new)
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
  erb(:edit)
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
  erb(:show)
end
