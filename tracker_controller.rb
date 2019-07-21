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

# INDEX TAGS
get '/transactions/tags' do
  @tags = Tag.all
  erb(:tags)
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
  redirect to '/transactions/new-merchant'
end

#NEW TAG
get '/transactions/new-tag' do
  @tags = Tag.all
  erb(:new_tag)
end

post '/transactions/tag' do
  Tag.new(params).save
  redirect to '/transactions/new-tag'
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

#EDIT TAG
get '/transactions/:id/edit-tag' do
  @tags = Tag.find(params['id'])
  erb(:edit_tag)
end
post '/transactions/:id/change-tag' do
  tag = Tag.new(params)
  tag.update
  redirect to "/transactions/tags"
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

#DELETE TAG
post '/transactions/:id/delete-tag' do
  Tag.delete(params['id'])
  redirect to '/transactions/tags'
end


#SHOW
get '/transactions/:id' do
  @transaction = Transaction.find(params['id'])
  @tag = Tag.all
  @merchant = Merchant.all
  erb(:show)
end
