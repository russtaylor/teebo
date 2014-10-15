require 'minitest/autorun'
require 'teebo'

class CreditCardTest < MiniTest::Test
  # Verifies that the length of a string generated by the 'CreditCard.number_to_digits' method
  # matches the length passed in.
  def test_cc_generate_length
    assert_equal 13,
                 Teebo::CreditCard.number_with_length(13).length
    assert_equal 20,
                 Teebo::CreditCard.number_with_length(20).length
    assert_equal 23,
                 Teebo::CreditCard.number_with_length(23).length
  end

  # Verifies that the 'Luhn Algorithm' function generates the correct output - signifying that the
  # check digit for generated credit card numbers will be valid.
  def test_luhn_algorithm
    assert_equal '4',
                 Teebo::CreditCard.luhn_algorithm(4034424)
    assert_equal '9',
                 Teebo::CreditCard.luhn_algorithm(32474445663225447)
    assert_equal '0',
                 Teebo::CreditCard.luhn_algorithm(344564322742543)
  end

  def test_last_digit_validation
    assert_equal '477222147225',
                 Teebo::CreditCard.last_digit_validation('477222147224')
    assert_equal '26',
                 Teebo::CreditCard.last_digit_validation('24')
    assert_equal '21454476127445730757',
                 Teebo::CreditCard.last_digit_validation('21454476127445730752')
  end

end