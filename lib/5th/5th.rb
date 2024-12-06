def transform_txt(string)
  rules = Hash.new { |hash, key| hash[key] = [] }
  updates = []
  lines = string.split("\n")
  lines.each do |line|
    if /(\d+)\|(\d+)/.match?(line)
      rule = /(\d+)\|(\d+)/.match(line)
      rules[rule[1]] << rule[2].to_i
    elsif line != ''
      update = line.split(',').map(&:to_i)
      updates << update
    end
  end
  [rules, updates]
end

def update_valid(update, rules, fix)
  for index in 0...(update.length - 1)
    key = update[index].to_s
    if rules[key].include?(update[index + 1])
      next
    elsif fix == true
      update[index], update[index + 1] = update[index + 1], update[index]
      return update_valid(update, rules, true)
    else
      return 0
    end
  end
  update[(update.length / 2).ceil]
end

def check_updates(string)
  result = transform_txt(string)
  rules = result[0]
  updates = result[1]

  counter = 0
  updates.each do |update|
    counter += update_valid(update, rules, false)
  end
  counter
end

def fix_update(string)
  result = transform_txt(string)
  rules = result[0]
  updates = result[1]

  result_1 = 0
  result_2 = 0

  updates.each do |update|
    result_1 += update_valid(update, rules, false)
    result_2 += update_valid(update, rules, true)
  end
  result_2 - result_1
end

File.open('lib/5th/data.txt') do |file|
  string = file.read
  result = transform_txt(string)
  puts result[0].inspect
  puts result[1].inspect

  puts 'result ', check_updates(string)
  puts 'fix', fix_update(string)
end
