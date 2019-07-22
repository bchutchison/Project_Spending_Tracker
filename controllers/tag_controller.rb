require('sinatra')
require('sinatra/reloader')
require('pry-byebug')

require_relative('../models/transaction.rb')
require_relative('../models/tag.rb')
require_relative('../models/merchant.rb')
also_reload('../models/*')


# INDEX TAGS
get '/tags' do
  @tags = Tag.all
  erb(:"tags/index")
end


#NEW TAG
get '/tags/new-tag' do
  @tags = Tag.all
  erb(:"tags/new_tag")
end

post '/tags' do
  Tag.new(params).save
  redirect to '/tags/new-tag'
end

#EDIT TAG
get '/tags/:id/edit-tag' do
  @tags = Tag.find(params['id'])
  erb(:"tags/edit_tag")
end
post '/tags/:id/change-tag' do
  tag = Tag.new(params)
  tag.update
  redirect to '/tags'
end

#DELETE TAG
post '/tags/:id/delete-tag' do
  Tag.delete(params['id'])
  redirect to '/tags'
end
