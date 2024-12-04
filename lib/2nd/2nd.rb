def verify_valid(levels)
  previous = levels[0].to_i
  index = 1
  ascending = nil
  tolerate = true
  while index < levels.length

    signed_delta = levels[index].to_i - previous
    delta = signed_delta.abs

    if delta < 1 || delta > 3
      return false unless tolerate

      tolerate = false
      index += 2
      next
    end

    if !ascending.nil? && ascending != signed_delta.positive?
      return false unless tolerate

      tolerate = false
      index += 2
      next
    end

    ascending = signed_delta.positive? if ascending.nil?
    previous = levels[index].to_i
    index += 1

  end
  true
end

valid_records = 0

File.open('lib/2nd/data.txt') do |file|
  string_file = file.read

  lines = string_file.split("\n")
  lines.each do |line|
    levels = line.split(' ')
    valid_records += 1 if verify_valid(levels)
  end
end

puts 'Valid records', valid_records
