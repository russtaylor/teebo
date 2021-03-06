module Teebo
  #
  # Generates names in accordance with their frequency in the United States
  # population.
  #
  class Name < TeeboGenerator

    GIVEN_NAMES_TABLE = 'given_names'
    SURNAMES_TABLE = 'surnames'

    #
    # Picks a random first & last name, selecting a random gender if it's not
    # specified.
    #
    def self.generate_name (sex=nil)
      if sex.nil?
        sex = %w(M F).sample
      end
      generate_given_name(sex) + ' ' + generate_surname
    end

    #
    # Generates a normal full name, including a middle name.
    #
    # For now, this is fairly sloppy, as the probability that a middle name will
    # simply be another given name of the same gender is almost certainly less
    # than 100%.
    #
    def self.generate_full_name(sex=nil)
      # TODO: Take into account different probabilities of different types of middle names.
      if sex.nil?
        sex = %w(M F).sample
      end
      generate_given_name(sex) + ' ' + generate_given_name(sex) + ' ' + generate_surname
    end

    #
    # Finds the total count for the number of names in the database.
    #
    def self.sum_count(sex)
      db_connection.get_sum(GIVEN_NAMES_TABLE, 'count', {column: 'sex', condition: sex})
    end

    #
    # Selects a random (weighted) given name from the database.
    #
    def self.generate_given_name(sex)
      count = sum_count(sex)
      selection = rand(count)
      db_connection.get_row_for_count(GIVEN_NAMES_TABLE, 'count_to', selection,
                                {column: 'sex', condition: sex})['name']
    end

    #
    # Selects a random (weighted) surname from the database.
    #
    def self.generate_surname
      count = db_connection.get_sum(SURNAMES_TABLE, 'count')
      selection = rand(count)
      db_connection.get_row_for_count(SURNAMES_TABLE, 'count_to', selection)['name']
    end
  end
end
