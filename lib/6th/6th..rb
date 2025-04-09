File.open("lib/6th/test.rb") do |file|
  string =file.read()
  lines = string.split()

end

def find_inital(lines)
  for index in 0...lines.length
    for char in lines[index].length
      if char == "^"
    end
  end
end