require 'minitest/autorun'
require 'teebo'

class TeeboTest < MiniTest::Test
  # Verifies that the length of a string generated by the 'CreditCard.number_to_digits' method
  # matches the length passed in.
  def test_cc_generate_length
    cc = Teebo::CreditCard.new
    assert_equal 13,
                 cc.number_to_digits(13).length
    assert_equal 20,
                 cc.number_to_digits(20).length
    assert_equal 23,
                 cc.number_to_digits(23).length
  end

  # Verifies that the 'Luhn Algorithm' function generates the correct output - signifying that the
  # check digit for generated credit card numbers will be valid.
  def test_luhn_algorithm
    cc = Teebo::CreditCard.new
    assert_equal '4',
                 cc.luhn_algorithm(4034424)
    assert_equal '9',
                 cc.luhn_algorithm(32474445663225447)
    assert_equal '0',
                 cc.luhn_algorithm(344564322742543)
  end

end