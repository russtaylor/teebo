require 'sqlite3'

module Teebo

  class Base

    def initialize
      # Initialize the database
      @@database = SQLite3::Database.new "lib/data/seed-data.db"
      @@database.results_as_hash = true
    end

    def weight

    end

    def update_sum_count
      sexes = ['M', 'F']
      sexes.each do |sex|
        get_rows = <<-SQL
          select * from given_names where sex = ?
        SQL

        put_count_to = <<-SQL
          update given_names set count_to = ? where id = ?
        SQL

        count = 0
        @database.execute(get_rows, sex) do |row|
          count += row['count']
          database.execute(put_count_to, count, row[0])
        end
      end
    end
  end
end

require_relative 'teebo/name'
