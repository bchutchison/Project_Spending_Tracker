require_relative('../models/merchant.rb')
require_relative('../models/tag.rb')
require_relative('../models/transaction.rb')
require('pry-byebug')

Transaction.delete_all()
Tag.delete_all()
Merchant.delete_all()


merchant1 = Merchant.new({
  'name' => 'Amazon'
})
merchant1.save()


tag1 = Tag.new({
  'name' => 'Entertainment'
})
tag1.save()


transaction1 = Transaction.new({
  'tag_id' => tag1.id,
  'merchant_id' => merchant1.id,
  'value' => 20,
  'details' => 'Purchased DVD'
})
transaction1.save()

transaction2 = Transaction.new({
  'tag_id' => tag1.id,
  'merchant_id' => merchant1.id,
  'value' => 50,
  'details' => 'Purchased hifi'
})
transaction2.save()



binding.pry
nil
