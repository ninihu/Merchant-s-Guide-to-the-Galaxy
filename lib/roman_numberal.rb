module Galaxy
  #对字母进行解析
  class RomanNumberal
    @@roman_values = {I: 1, V: 5, X: 10, L: 50, C: 100, D: 500, M: 1000}
    @@allow_repeat = [:I, :X, :C, :M]
    @@can_substract = ["IV", "IX", "XL", "XC", "CD", "CM"]

    attr_accessor :roman_string
    attr_reader :value

    def initialize(roman_string)
      @roman_string = roman_string
      @value = calculate
    end



    def calculate
      #  valid?
      result = 0
      index = 0
      while index < @roman_string.length do
        current_data = @@roman_values[@roman_string[index].to_sym]
        # puts current_data
        if !current_data
          invalid_string
        end

        #如果是最后一个字符
        if index == @roman_string.length - 1
          result += current_data
          break
        end

        next_data = @@roman_values[@roman_string[index + 1].to_sym]
        if !next_data
          invalid_string
        end

        if next_data < current_data
          result += current_data
        end
        #如果相等，需判断是否允许循环，循环3次以上
        if next_data == current_data
          if !@@allow_repeat.index(@roman_string[index].to_sym) || @roman_string.index(/#{@roman_string[index]}{4,}/)
            invalid_string
          else
            result += current_data
          end
        end
        #如果后一数字大于前一数字，验证是否符合can substacted
        if next_data > current_data
          if @@can_substract.any?{|sub| sub == @roman_string[index, 2] }
            result += next_data - current_data
            index += 1
          else
            invalid_string
          end
        end
        index += 1
      end
      return result
    end

    def invalid_string
      raise StringFormatException, "#{@roman_string} is invalid."
    end
  end


end
