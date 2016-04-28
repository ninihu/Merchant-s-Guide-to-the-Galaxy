require File.dirname(__FILE__) + '/galaxy'
# puts Galaxy::RomanNumberal.new('XIV').value
# puts Galaxy::RomanNumberal.new('MMVI').value
# puts Galaxy::RomanNumberal.new('MCMXLIV').value
# puts Galaxy::RomanNumberal.new('MCMIII').value
# puts Galaxy::ParseInput.new('glob is XIV').keyword
obj = Galaxy::ParseInput.new
loop do
  input = obj.get_input
end
