require 'yaml'
require 'sqlite3'

class Teebo

  def initialize
    # Initialize the database
    @database = SQLite3::Database.new "lib/data/seed-data.db"
  end

  def weight

  end

  def sum_count sex
    statement = <<-SQL
      select sum(count) from 'given_names' where sex = ?
    SQL
    count = @database.execute(statement, sex)
  end

end
