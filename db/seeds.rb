require_relative('../models/merchant.rb')
require_relative('../models/tag.rb')
require_relative('../models/transaction.rb')
require('pry-byebug')

Transaction.delete_all()
Tag.delete_all()
Merchant.delete_all()


merchant1 = Merchant.new({'name' => 'Amazon'})
merchant1.save()

merchant2 = Merchant.new({'name' => 'Tesco'})
merchant2.save()

merchant3 = Merchant.new({'name' => 'Asda'})
merchant3.save()

merchant4 = Merchant.new({'name' => 'Ebay'})
merchant4.save()


tag1 = Tag.new({'name' => 'Entertainment'})
tag1.save()

tag2 = Tag.new({'name' => 'Groceries'})
tag2.save()


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
