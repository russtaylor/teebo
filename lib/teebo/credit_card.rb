module Teebo
  #
  # Helper class for generating credit card numbers. Categorizes cards according to their card
  # issuer, while attempting to maintain a realistic distribution between the issuers. Also ensures
  # that the credit card numbers are actually valid.
  #
  class CreditCard < TeeboGenerator

    def self.issuers
      @cc_issuers ||= yaml_mapping['credit-card-issuers']
    end

    def self.generate_card(issuer=nil)
      if issuer.nil?
        issuer = generate_issuer
      end
      [
          'issuer' => issuer['name'],
          'number' => generate_number(issuer),
          'cvv' => generate_cvv_code(issuer),
          'expiration' => generate_expiration_date
      ]
    end

    #
    # Returns a credit card issuer according to the likelihood that it would be seen in the wild.
    #
    def self.generate_issuer
      random_choice = Random.rand
      full_weight = 0
      issuers.each do |issuer|
        full_weight += issuer['probability']
        if random_choice < full_weight
          return issuer
        end
      end
    end

    #
    # Generates a credit card number according to the pattern specified in the 'issuer' passed in.
    #
    def self.generate_number(issuer)
      # TODO: Sample according to realistic distribution - numbers w/long prefixes are prioritized too highly right now.
      prefix = issuer['iin-prefixes'].sample.to_s
      length = issuer['lengths'].sample
      generated = number_with_length(length - prefix.length)
      number = prefix + generated
      if issuer['validation']
        last_digit_validation(number)
      end
    end

    #
    # Gets the sum of the digits of the specified number, with every other digit doubled. Necessary
    # to calculate a credit card's check digit.
    #
    def self.luhn_sum(number)
      digits = number.to_s.chars.map(&:to_i)
      digits.reverse.each_slice(2).map do |x, y|
        [(x * 2).divmod(10), y || 0]
      end.flatten.inject(:+)
    end

    #
    # A simple implementation of the [Luhn algorithm](http://en.wikipedia.org/wiki/Luhn_algorithm),
    # which all U.S.-based Credit Card issuers use for the validation check on credit card numbers.
    #
    def self.luhn_algorithm(number)
      digit_sum = luhn_sum(number)
      ((10 - digit_sum % 10) % 10).to_s
    end

    #
    # Uses the Luhn algorithm to replace the last digit in the generated number with the correct
    # check digit.
    #
    def self.last_digit_validation(number)
      trimmed_number = number[0..-2]
      check_digit = luhn_algorithm(trimmed_number)
      trimmed_number + check_digit
    end

    #
    # Generates a random number with the specified number of digits, padding the beginning with
    # '0' characters, if necessary.
    #
    def self.number_with_length(length)
      length = length.to_i
      rand(10 ** length).to_s.rjust(length,'0')
    end

    #
    # Generates a Credit Card CVV code. This simply returns a random number of the length used by
    # the specified 'issuer' object.
    #
    def self.generate_cvv_code(issuer)
      number_with_length(issuer['cvv-length'])
    end

    #
    # Generates an expiration date for a credit card. These dates are, somewhat arbitrarily, simply
    # some time in the next 5 years.
    #
    def self.generate_expiration_date
      current_year = Time.now.year - 2000
      month = rand(1...13)
      if month <= Time.now.month
        current_year += 1
      end
      year = rand(current_year...(current_year + 5))
      month = month.to_s.rjust(2,'0')
      "#{month}/#{year}"
    end
  end
end