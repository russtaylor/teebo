module Teebo
  # This class facilitates the use of the database that accompanies this gem. Its primary goal is to
  # simplify querying the database for required data, without having to write raw SQL statements
  # throughout the codebase.
  #
  # Author:: Russ Taylor (mailto:russ@russt.me)
  class Database
    def initialize
      @database = SQLite3::Database.new 'lib/data/seed-data.db'
      @database.results_as_hash = true
    end

    def get_count(table_name, row_name, where_clause=nil)
      where_statement = ''
      unless where_clause.nil?
        where_statement = "where #{where_clause[:row]} = #{where_clause[:condition]}"
      end
      statement = <<-SQL
        select count(#{row_name}) from #{table_name}
        #{where_statement}
      SQL

      @database.execute(statement)[0][0]
    end
  end
end