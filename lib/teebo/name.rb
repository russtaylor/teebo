module Teebo
  #
  # Generates names in accordance with their frequency in the United States
  # population.
  #
  class Name < Base

    #
    # Picks a random full name, selecting a random gender if it's not specified.
    #
    def name sex=nil
      if sex.nil?
        sex = ['M', 'F'].sample
      end
      given_name(sex) + " " + surname
    end

    #
    # Finds the total count for the number of names in the database.
    #
    def sum_count sex
      find_count = <<-SQL
        select sum(count) from 'given_names' where sex = ?
      SQL
      @database.execute(find_count, sex)[0][0]
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
      selection = rand(count)
      @database.execute(find_range_query, sex, selection)[0]['name']
    end

    #
    # Selects a random (weighted) surname from the database.
    #
    def surname
      find_range_query = <<-SQL
        select * from surnames where (count_to - ?) >= 0 order by id limit 1
      SQL

      count = @database.execute('select sum(count) from surnames')[0][0]
      selection = rand(count)
      @database.execute(find_range_query, selection)[0]['name']
    end
  end
end
