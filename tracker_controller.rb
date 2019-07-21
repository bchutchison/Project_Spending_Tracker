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


#NEW MERCHANT
get '/transactions/new-merchant' do
  @merchants = Merchant.all
  erb(:new_merchant)
end

post '/transactions/merchant' do
  Merchant.new(params).save
  redirect to '/transactions'
end


#NEW TAG
get '/transactions/new-tag' do
  @tags = Tag.all
  erb(:new_tag)
end

post '/transactions/tag' do
  Tag.new(params).save
  redirect to '/transactions'
end


#EDIT
get '/transactions/:id/edit' do
  @tags = Tag.all
  @merchants = Merchant.all
  @transactions = Transaction.find(params['id'])
  erb(:edit)
end

# EDIT TAGS
get '/transactions/edit-tags' do
  @tags = Tag.all
  erb(:edit_tags)
end

#EDIT MERCHANTS
get '/transactions/edit-merchants' do
  @merchants = Merchant.all
  erb(:edit_merchants)
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
