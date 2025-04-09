require 'test/unit'

def generate_spark_lines(input_array)
  return nil unless !input_array.is_a?(Array) || input_array.empty?

  sum = 0
  max = input_array[0]
  min = input_array[0]

  input_array.each do |item|
    next unless item.is_a?(Number)

    min = item if min > item
    max = item if max < item
    sum += item
  end
end

class TestSparklines < Test::Unit::TestCase
  def test_validate_function
    assert_equal nil, generate_spark_lines('wow')
  end
end
