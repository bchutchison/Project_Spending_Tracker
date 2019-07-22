require('sinatra')
require('sinatra/reloader')
require('pry-byebug')

require_relative('../models/transaction.rb')
require_relative('../models/tag.rb')
require_relative('../models/merchant.rb')
also_reload('../models/*')

#INDEX MERCHANTS
get '/merchants' do
  @merchants = Merchant.all
  erb(:"merchants/index")
end


#NEW MERCHANT
get '/merchants/new-merchant' do
  @merchants = Merchant.all
  erb(:"merchants/new_merchant")
end

post '/merchants' do
  Merchant.new(params).save
  redirect to '/merchants/new-merchant'
end


#EDIT MERCHANT
get '/merchants/:id/edit-merchant' do
  @merchants = Merchant.find(params['id'])
  erb(:"merchants/edit_merchant")
end
post '/merchants/:id/change-merchant' do
  merchant = Merchant.new(params)
  merchant.update
  redirect to "/merchants"
end


#DELETE MERCHANT
post '/merchants/:id/delete-merchant' do
  Merchant.delete(params['id'])
  redirect to '/merchants'
end
