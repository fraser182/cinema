require_relative('../db/sql_runner')
require_relative('./film.rb')
require_relative('./customer.rb')

class Ticket

  attr_reader :id
  attr_accessor :film_id, :customer_id

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @film_id = options['film_id'].to_i
    @customer_id = options['customer_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets (film_id, customer_id) VALUES($1, $2) RETURNING id;"
    values = [@film_id, @customer_id]
    ticket = SqlRunner.run(sql,values).first()
    @id = ticket['id'].to_i
  end

  def self.all()  #READ Ticket.all p all films
    sql = "SELECT * FROM tickets"
    tickets = SqlRunner.run(sql)
    result = tickets.map { |ticket| Ticket.new( ticket ) }
    return result
  end

  def self.find(id) # READ Ticket.find(1) p Ticket 1 all details
    sql = "SELECT * FROM tickets
    WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    ticket_hash = result[0]
    ticket = Ticket.new(ticket_hash)
    return ticket
  end

  def delete() #DELETE ticket1.delete (removes 1 ticket)
    sql = "DELETE FROM tickets WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all() #DELETE Tickets.delete_all (removes all tickets)
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end



end
