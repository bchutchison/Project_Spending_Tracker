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



#INDEX MERCHANTS
get '/transactions/merchants' do
  @merchants = Merchant.all
  erb(:merchants)
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



#NEW MERCHANT
get '/transactions/new-merchant' do
  @merchants = Merchant.all
  erb(:new_merchant)
end

post '/transactions/merchant' do
  Merchant.new(params).save
  redirect to '/transactions/new-merchant'
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

#EDIT MERCHANT
get '/transactions/:id/edit-merchant' do
  @merchants = Merchant.find(params['id'])
  erb(:edit_merchant)
end
post '/transactions/:id/change-merchant' do
  merchant = Merchant.new(params)
  merchant.update
  redirect to "/transactions/merchants"
end





#DELETE
post '/transactions/:id/delete' do
  Transaction.delete(params['id'])
  redirect to '/transactions'
end

#DELETE MERCHANT
post '/transactions/:id/delete-merchant' do
  Merchant.delete(params['id'])
  redirect to '/transactions/merchants'
end




#SHOW
get '/transactions/:id' do
  @transaction = Transaction.find(params['id'])
  @tag = Tag.all
  @merchant = Merchant.all
  erb(:"transactions/show")
end
