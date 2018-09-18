require('pry')
require_relative("./models/property.rb")

# Commented out to make other methods easier to run:
# Property.delete_all()

property1 = Property.new({
  'address' => "206 Accacia Avenue",
  'build' => "detatched",
  'no_bedrooms' => 3,
  'value' => 2500000
})

property1.save()

property2 = Property.new({
  'address' => "10 Downing Street",
  'build' => "semi-detatched",
  'no_bedrooms' => 9,
  'value' => 75000000
})

property2.save()

# Commented out to make other methods easier to run :
# property1.delete()

property1.value = 300000
property1.update()

found = Property.find_by_id(1)

Property.find_by_address("10 Downing Street")

properties = Property.all()

binding.pry
nil
