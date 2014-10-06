module Teebo
  #
  # Helper class for generating credit card numbers. Categorizes cards according to their card
  # issuer, while attempting to maintain a realistic distribution between the issuers. Also ensures
  # that the credit card numbers are actually valid.
  #
  class CreditCard < TeeboGenerator

    def initialize
      super
      @cc_issuers = @yaml_mapping['credit-card-issuers']
    end

    #
    # Returns a credit card issuer according to the likelihood that it would be seen in the wild.
    #
    def weighted_issuer
      random_choice = Random.rand
      full_weight = 0
      @cc_issuers.each do |issuer|
        full_weight += issuer['probability']
        if random_choice < full_weight
          return issuer
        end
      end
    end

    #
    # Generates a credit card number according to the pattern specified in the 'issuer' passed in.
    #
    def generate_number(issuer)
      # TODO: Sample according to realistic distribution - numbers w/long prefixes are prioritized too highly right now.
      prefix = issuer['iin-prefixes'].sample
      length = issuer['lengths'].sample
      puts prefix, length
    end



  end
end