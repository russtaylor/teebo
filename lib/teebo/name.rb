module Teebo
  #
  # Generates names in accordance with their frequency in the United States
  # population.
  #
  class Name < Base

    #
    # Finds the total count for the number of names in the database.
    #
    def sum_count sex
      find_count = <<-SQL
        select sum(count) from 'given_names' where sex = ?
      SQL
      return @@database.execute(find_count, sex)[0][0]
    end

    #
    # Selects a random (weighted) given name from the database.
    #
    def given_name sex
      find_range_query = <<-SQL
        select * from given_names where sex = ?
          and (count_to - ?) >= 0
          order by id limit 1
      SQL

      count = sum_count sex
      rand = rand(count)
      return @@database.execute(find_range_query, sex, rand)[0]['name']
    end
  end
end
