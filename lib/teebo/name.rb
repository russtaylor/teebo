module Teebo
  #
  # Generates names in accordance with their frequency in the United States
  # population.
  #
  class Name < TeeboGenerator

    #
    # Picks a random first & last name, selecting a random gender if it's not
    # specified.
    #
    def name (sex=nil)
      if sex.nil?
        sex = %w(M F).sample
      end
      given_name(sex) + ' ' + surname
    end

    #
    # Generates a normal full name, including a middle name.
    #
    # For now, this is fairly sloppy, as the probability that a middle name will
    # simply be another given name of the same gender is almost certainly less
    # than 100%.
    #
    def full_name(sex=nil)
      # TODO: Take into account different probabilities of different types of middle names.
      if sex.nil?
        sex = %w(M F).sample
      end
      given_name(sex) + ' ' + given_name(sex) + ' ' + surname
    end

    #
    # Finds the total count for the number of names in the database.
    #
    def sum_count(sex)
      @db_connection.get_sum('given_names', 'count', [row: 'sex', condition: sex])
    end

    #
    # Selects a random (weighted) given name from the database.
    #
    def given_name(sex)
      find_range_query = <<-SQL
        select * from given_names where sex = ?
          and (count_to - ?) >= 0
          order by id limit 1
      SQL

      count = sum_count(sex)
      selection = rand(count)
      @db_connection.database.execute(find_range_query, sex, selection)[0]['name']
    end

    #
    # Selects a random (weighted) surname from the database.
    #
    def surname
      find_range_query = <<-SQL
        select * from surnames where (count_to - ?) >= 0 order by id limit 1
      SQL

      count = @db_connection.get_sum('surnames', 'count')
      selection = rand(count)
      @db_connection.database.execute(find_range_query, selection)[0]['name']
    end
  end
end
