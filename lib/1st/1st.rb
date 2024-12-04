require 'csv'

file_path = 'lib/data.csv'

left_list = []
right_list = []

CSV.foreach(file_path, col_sep: ',') do |row|
  left_list.push(row[0].to_i)
  right_list.push(row[1].to_i)
end

s_left_list = left_list.sort
s_right_list = right_list.sort

distance = 0

(0...s_left_list.length).each do |i|
  distance += (s_left_list[i] - s_right_list[i]).abs
end

puts('Distance is equal to : ', distance)

similarity =0

(0...left_list.length).each do |i|
  similarity += left_list[i] * right_list.count(left_list[i])
end

puts('similarity is equal to', similarity)