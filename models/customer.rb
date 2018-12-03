require_relative ('../db/sql_runner')
require_relative('./ticket.rb')
require_relative('./film.rb')

class Customer

  attr_reader :id
  attr_accessor :funds, :name


  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i()

  end

  def save() #CREATE
    # create sql string
    sql = "INSERT INTO customers (name,funds) VALUES ($1,$2) RETURNING id"
    # define values
    values = [@name, @funds]
    # run SqlRunner for exec prepared
    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i
  end

  def self.all() #READ Customer.all p all customers
    sql = "SELECT * FROM customers"
    customers = SqlRunner.run(sql)
    return customers.map { |customer| Customer.new(customer) }
  end

# Find all customer details by id.
  def self.find(id) # READ Customer.find(1) p Customer 1 all details
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    customer_hash = result[0]
    customer = Customer.new(customer_hash)
    return customer
  end

# Find all customer details by name
  def self.find_by_name(name) # READ Customer.find_by_name("Lady Ross")
    sql = "SELECT * FROM customers WHERE name = $1"
    values = [name]
    result = SqlRunner.run(sql, values)
    customer_hash = result[0]
    customer = Customer.new(customer_hash)
    return customer
  end

# Update a customer (name or funds avaliable)
  def update() #UPDATE customer1.funds = 10 then customer1
    sql = "UPDATE customers SET (name,funds) = ($1, $2) RETURNING id = $3"
    values = [@name, @funds, @id]
    result = SqlRunner.run(sql, values)
  end

# Delete a customer
  def delete() #DELETE customer1.delete (removes 1 customer)
    sql = "DELETE FROM customers WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

# Delete all tickets from all customers
  def self.delete_all #DELETE Customer.delete_all, deletes all customers
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

# Show all films a customer has a ticket to
  def all_films() # RETURN customer2.all_films (returns all films from that customer)
    sql = "SELECT films.* FROM films INNER JOIN tickets ON films.id = tickets.film_id
    WHERE tickets.customer_id = $1"
    values = [@id]
    films = SqlRunner.run(sql, values)
    result = films.map { |film| Film.new(film) }
    return result
  end

# Show all details from a certain customer by id.
  def self.find(id) # READ Customer.find(1) p Customer 1 all details
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    customer_hash = result[0]
    customer = Customer.new(customer_hash)
    return customer
  end

  # Update customers funds by buying a ticket
  def buy_ticket(film) # Update customer1.buy_tickets(film1)
    sql = "UPDATE customers SET funds = $1 WHERE id = $2"
    funds = @funds - film.price
    values = [funds, @id]
    result = SqlRunner.run(sql, values)
  end

# Counts number of Customers going to see a certain film
  def count_tickets_bought() # Read customer1.count_tickets_bought
    sql = "SELECT COUNT(id) FROM tickets WHERE customer_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    count_hash = result[0]
    return count_hash['count']
  end

end
