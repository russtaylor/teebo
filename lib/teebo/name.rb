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
      @db_connection.get_sum('given_names', 'count', {column: 'sex', condition: sex})
    end

    #
    # Selects a random (weighted) given name from the database.
    #
    def given_name(sex)
      count = sum_count(sex)
      selection = rand(count)
      @db_connection.get_row_at('given_names', 'count_to', selection, {column:'sex', condition:sex})['name']
    end

    #
    # Selects a random (weighted) surname from the database.
    #
    def surname
      count = @db_connection.get_sum('surnames', 'count')
      selection = rand(count)
      @db_connection.get_row_at('surnames', 'count_to', selection)['name']
    end
  end
end
