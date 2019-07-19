require_relative('../models/merchant.rb')
require_relative('../models/tag.rb')
require_relative('../models/transaction.rb')
require('pry-byebug')

Transaction.delete_all()
Tag.delete_all()
Merchant.delete_all()

merchant1 => Merchant.new({
  'name' => 'Amazon'
})

tag1 => Tag.new({
  'name' => 'Entertainment'
})

transaction1 = Transaction.new({
  'tag_id' => tag1.id,
  'merchant_id' => merchant1.id,
  'value' => 20
})



binding.pry
nil
