require_relative ('models/film')
require_relative ('models/customer')
require_relative ('models/ticket')
require('pry')

# Ticket.delete_all()
Film.delete_all()
Customer.delete_all()

film1 = Film.new(
  {
    'title' => 'Santa Claus The Movie',
    'price' => '8'
  }
)

film1.save()

film2 = Film.new(
  {
    'title' => 'The Polar Express',
    'price' => '9'
  }
)

film2.save()


customer1 = Customer.new(
  {
    'name' => 'Lindsay McKenzie',
    'funds' => '15'
  }
)

customer1.save()

customer2 = Customer.new(
  {
    'name' => 'Lady Ross',
    'funds' => '10'

  }
)

customer2.save()

customer3 = Customer.new(
  {
    'name' => 'Belle McKenzie Ross',
    'funds' => '25'
  }
)

customer3.save()


ticket1 = Ticket.new(
  {
    'customer_id' => customer1.id,
    'film_id'     => film1.id

  }
)
ticket1.save()

ticket2 = Ticket.new(
  {
    'customer_id' => customer2.id,
    'film_id'     => film1.id

  }
)
ticket2.save()

ticket3 = Ticket.new(
  {
    'customer_id' => customer3.id,
    'film_id'     => film1.id

  }
)
ticket3.save()

ticket4 = Ticket.new(
  {
    'customer_id' => customer2.id,
    'film_id'     => film2.id

  }
)
ticket4.save()

ticket5 = Ticket.new(
  {
    'customer_id' => customer3.id,
    'film_id'     => film2.id

  }
)
ticket5.save()

ticket6 = Ticket.new(
  {
    'customer_id' => customer3.id,
    'film_id'     => film2.id

  }
)
ticket6.save()

ticket7 = Ticket.new(
  {
    'customer_id' => customer3.id,
    'film_id'     => film2.id

  }
)
ticket7.save()


binding.pry
nil
