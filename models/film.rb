require_relative ('../db/sql_runner')
require_relative('./ticket.rb')
require_relative('./customer.rb')

class Film

  attr_reader :id
  attr_accessor :title, :price


  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i()

  end

  def save() #CREATE
    # create sql string
    sql = "INSERT INTO films (title,price) VALUES ($1,$2) RETURNING id"
    # define values
    values = [@title, @price]
    # run SqlRunner for exec prepared
    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i
  end

# Find all details of all films
  def self.all() #READ Film.all p all films
    sql = "SELECT * FROM films"
    films = SqlRunner.run(sql)
    return films.map { |film| Film.new(film) }
  end

# Find a film by ID number
  def self.find(id) # READ Film.find(1) p Film 1 all details
    sql = "SELECT * FROM films WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    film_hash = result[0]
    film = Film.new(film_hash)
    return film
  end

# Find a film by it's title
  def self.find_by_title(title) # READ Film.find_by_title("Santa Claus The Movie")
    sql = "SELECT * FROM films WHERE title = $1"
    values = [title]
    result = SqlRunner.run(sql, values)
    film_hash = result[0]
    film = Film.new(film_hash)
    return film
  end

# Updates a film (price or title avaliable to change)
  def update() #UPDATE film1.price = 10 then film1
    sql = "UPDATE films SET (title,price) = ($1, $2) RETURNING id = $3"
    values = [@title, @price, @id]
    result = SqlRunner.run(sql, values)

  end

# Deletes a certain film
  def delete() #DELETE film1.delete (removes 1 film)
    sql = "DELETE FROM films WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

# Deletes all films
  def self.delete_all #DELETE Film.delete_all, deletes all films
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

# Returns all customers attending a certain film
  def all_customers() # RETURN film1.all_customers (returns all customers attending that film)
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON customers.id = tickets.customer_id
    WHERE tickets.film_id = $1"
    values = [@id]
    customers = SqlRunner.run(sql, values)
    result = customers.map { |customer| Customer.new(customer) }
    return result
  end

# Counts the number of customers attending a certain film
  def all_customers_alt() # Read film1.all_customers_alt
    sql = "SELECT COUNT(id) FROM tickets WHERE film_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    count_hash = result[0]
    return count_hash['count']
  end

end
