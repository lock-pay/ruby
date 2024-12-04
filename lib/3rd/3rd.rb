require 'test/unit'

def scan_memory(string)
  result = 0
  all_elements = string.scan(/mul\((\d{1,3}),(\d{1,3})\)/)
  all_elements.each do |element|
    result += element[0].to_i * element[1].to_i
  end
  result
end

File.open('lib/3rd/data.txt') do |file|
  string_file = file.read
  puts scan_memory(string_file)
end

def scan_memory_v2(string)
  enabled = ''
  remaining = string
  loop do
    enabled_array = remaining.split("don't()", 2)
    enabled += enabled_array[0]
    break if enabled_array.length < 2

    remaining = enabled_array[1]
    disabled_array = remaining.split('do()', 2)
    break if disabled_array.length < 2

    remaining = disabled_array[1]
  end
  scan_memory(enabled)
end

File.open('lib/3rd/data.txt') do |file|
  string_file = file.read
  puts scan_memory_v2(string_file)
end

# class TestScanMemory < Test::Unit::TestCase
#   def test_validate_function
#     assert_equal 161, scan_memory('xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))')
#   end
# end

class TestScanMemoryV2 < Test::Unit::TestCase
  def test_validate_function
    assert_equal 48, scan_memory_v2("xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))")
  end
end
