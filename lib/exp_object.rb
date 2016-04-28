#encoding: utf-8
module Galaxy
  #字符串与roman number对应对象
  class ExpObject
    attr_accessor :keyword, :exp

    def initialize(keyword, exp)
      @keyword = keyword
      @exp = RomanNumberal.new(exp)
    end

    def to_s
      "#{@keyword} Credits is #{@exp.value}"
    end

  end
end
