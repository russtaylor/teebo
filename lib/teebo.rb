require 'yaml'
require 'sqlite3'

class Teebo

  def initialize
    # Initialize the database
    @database = SQLite3::Database.new "lib/data/seed-data.db"
  end

  def weight

  end

  def sum_count
    count = @database.execute <<-SQL
      select sum(count) from 'given_names' where sex = 'F'
    SQL
    print count
  end

end
