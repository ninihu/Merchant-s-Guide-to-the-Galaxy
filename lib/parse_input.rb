#encoding: utf-8
module Galaxy
  #对输入的文字进行解析
  class ParseInput
    @@input_strings = ["^[^ ]+ is [IVXLCDM]+$", "^.* is [0123456789]+ Credits"]
    @@output_strings = ["^how much is .* ?$", "^how many Credits is .* ?$"]
    attr_accessor :exp_objects, :know_values


    def initialize
      @exp_objects = []
      @know_values = {}
    end


    def get_input
      input = gets.chomp
      process_input(input)
    end


    def process_input(input)
      begin
      #eg: glob is I
        if /^(?<variable>[^ ]+) is (?<exp>[IVXLCDM]+)$/ =~ input
          if variable && exp
            @exp_objects << ExpObject.new(variable, exp)
          else
            cannot_understand
          end
        #eg: glob glob Silber is 34 Credits
        elsif /^(?<vars>.*) is (?<credits>[0123456789]+) Credits$/ =~ input
          if vars && credits
            set_credit(vars, credits)
          else
            cannot_understand
          end
        #eg: how much is pish tegj glob glob ?
      elsif /^how much is (?<exp>.*) ?\?$/ =~ input
          if exp
            how_much(exp)
          else
            cannot_understand
          end
      #eg:how many Credits is glob prok Silver ?
      elsif /^how many Credits is (?<expression>.*) ?\?$/ =~ input
          if expression
            how_many(expression)
          else
            cannot_understand
          end
        else
          cannot_understand
        end
      rescue Exception => e
        puts e.message
      end
    end

    def how_much(exp)
      result = calculate(exp)
      puts "#{exp} is #{result}"
      return result
    end




    def how_many(exp)
      vars = exp.split(' ')
      credit = vars.delete_at(-1)

      values = calculate(vars.join(' '))

      credits = @know_values[credit]
      if credits
        puts "#{exp} is #{(credits * values).to_i} Credits"
        return (credits * values).to_i
      else
        cannot_understand
      end
    end


    #golb golb Silver 34 => Silver = 17
    def set_credit(vars, credits)
      vars = vars.split(' ')
      credit = vars.delete_at(-1)
      values = calculate(vars.join(' '))
      @know_values[credit] = credits.to_f / values
    end

    #表达式计算罗马数字和
    # glob glob   => 2
    def calculate(exp)
      result = 0
      keys = exp.split(" ")
      final_exp = keys.collect do |key|
        exp_object = @exp_objects.find{|ob| ob.keyword == key}
        if exp_object
          exp_object.exp.roman_string
        else
          cannot_understand
        end
      end.join('')
      RomanNumberal.new(final_exp).value
    end



    def cannot_understand
      raise InvalidInputException, 'I have no idea what you are talking about'
    end

    def to_s
      @exp_objects.collect(&:to_s).join(',') + "\n" + @know_values.collect{|key, value| "#{key}=#{value}"}.join(',')
    end
  end
end
