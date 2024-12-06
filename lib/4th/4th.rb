require 'test/unit'

def word_search(string)
  lines = string.split
  counter = 0
  for line_index in 0...lines.length
    for char_index in 0...lines[line_index].length
      if lines[line_index][char_index] == 'X'
        counter += concatenate(lines, line_index, char_index, 'MAS')
      elsif lines[line_index][char_index] == 'S'
        counter += concatenate(lines, line_index, char_index, 'AMX')
      end
    end
  end
  counter
end

def concatenate(lines, line_index, char_index, string)
  counter = 0
  counter += find_diagonal_right(lines, line_index, char_index, string)
  counter += find_diagonal_left(lines, line_index, char_index, string)
  counter += find_horizonatl(lines, line_index, char_index, string)
  counter += find_vertical(lines, line_index, char_index, string)
  counter
end

def find_vertical(lines, line_index, char_index, string)
  return 0 if (line_index + 3) >= lines.length

  actual_string = (lines[line_index + 1][char_index] + lines[line_index + 2][char_index] + lines[line_index + 3][char_index])
  return 1 if string == actual_string

  0
end

def find_diagonal_right(lines, line_index, char_index, string)
  return 0 if (line_index + 3) >= lines.length || (char_index + 3) >= lines[line_index].length

  actual_string = lines[line_index + 1][char_index + 1] + lines[line_index + 2][char_index + 2] + lines[line_index + 3][char_index + 3]
  return 1 if string == actual_string

  0
end

def find_horizonatl(lines, line_index, char_index, string)
  return 0 if (char_index + 3) >= lines[line_index].length

  actual_string = lines[line_index][char_index + 1] + lines[line_index][char_index + 2] + lines[line_index][char_index + 3]
  return 1 if string == actual_string

  0
end

def find_diagonal_left(lines, line_index, char_index, string)
  return 0 if (char_index - 3) < 0 || (line_index + 3) >= lines.length

  actual_string = lines[line_index + 1][char_index - 1] + lines[line_index + 2][char_index - 2] + lines[line_index + 3][char_index - 3]
  return 1 if string == actual_string

  0
end

def word_search_v2(string)
  lines = string.split
  counter = 0
  for line_index in 0...lines.length
    for char_index in 0...lines[line_index].length
      counter += find_raising(lines, line_index, char_index) if lines[line_index][char_index] == 'A'
    end
  end
  counter
end

def find_raising(lines, line_index, char_index)
  if (char_index + 1) >= lines[line_index].length || char_index.zero? || line_index.zero? || (line_index + 1) >= lines.length
    return 0

  end

  tl = lines[line_index - 1][char_index - 1]
  tr = lines[line_index - 1][char_index + 1]
  br = lines[line_index + 1][char_index + 1]
  bl = lines[line_index + 1][char_index - 1]

  counter = 0
  counter += 1 if (tl == 'M' && br == 'S') || (tl == 'S' && br == 'M')

  counter += 1 if (tr == 'M' && bl == 'S') || (tr == 'S' && bl == 'M')
  return 1 if counter == 2

  0
end

File.open('lib/4th/data.txt') do |file|
  string_file = file.read

  puts word_search(string_file)
  puts word_search_v2(string_file)
end

class ValidateFirst < Test::Unit::TestCase
  def test_validate_function
    File.open('lib/4th/test.txt') do |file|
      string_file = file.read
      assert_equal 18, word_search(string_file)
    end
  end

  def test_validate_function_v2
    File.open('lib/4th/test.txt') do |file|
      string_file = file.read
      assert_equal 9, word_search_v2(string_file)
    end
  end
end
