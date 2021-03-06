module Teebo
  # This class facilitates the use of the database that accompanies this gem. Its primary goal is to
  # simplify querying the database for required data, without having to write raw SQL statements
  # throughout the codebase.
  #
  # Author:: Russ Taylor (mailto:russ@russt.me)
  class DatabaseHandler

    def initialize
      @database = SQLite3::Database.new 'lib/data/seed-data.db'
      @database.results_as_hash = true
    end

    #
    # Retrieves the sum of the specified column in the database. Optionally, a 'where' clause may
    # be specified to restrict the sum to rows meeting a specified condition. Note that at present,
    # only where clauses with one condition and an '=' comparison are supported.
    #
    def get_sum(table_name, column_name, where_clause=nil)
      where_statement = ''
      unless where_clause.nil?
        where_statement = "where #{where_clause[:column]} = '#{where_clause[:condition]}'"
      end
      statement = <<-SQL
        select sum(#{column_name}) from #{table_name} #{where_statement}
      SQL

      @database.execute(statement)[0][0]
    end

    #
    # Retrieves the one row from the database where the specified number fits into this row's
    # 'count_to' range.
    #
    def get_row_for_count(table_name, count_column, count_value, where_clause=nil)
      where_statement = ''
      unless where_clause.nil?
        where_statement = "and #{where_clause[:column]} = '#{where_clause[:condition]}'"
      end
      statement = <<-SQL
        select * from #{table_name} where (#{count_column} - #{count_value}) >= 0
        #{where_statement}
        order by id limit 1
      SQL

      @database.execute(statement)[0]
    end
  end
end