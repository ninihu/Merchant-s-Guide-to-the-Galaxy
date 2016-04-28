require 'spec_helper'
describe Galaxy::ParseInput do
  let(:parse_input) {Galaxy::ParseInput.new}
  describe "#input string" do
    context 'set roman number values' do
      it 'set correct values' do
        parse_input.process_input('glob is I')
        parse_input.process_input('prok is V')
        parse_input.process_input('pish is X')
        parse_input.process_input('tegj is L')
        parse_input.exp_objects.length.should eql(4)
      end

      it 'set incorrect values ' do
        parse_input.process_input('test is IM')
        parse_input.exp_objects.length.should eql(0)
      end
    end

    context 'set credits ' do
      it 'set correct values' do
        parse_input.process_input('glob is I')
        parse_input.process_input('prok is V')
        parse_input.process_input('pish is X')
        parse_input.process_input('tegj is L')
        parse_input.process_input('glob glob Silver is 34 Credits')
        parse_input.know_values['Silver'].should eql(17.0)
      end


    end



    context 'get number values' do
      it 'set correct values' do
        parse_input.process_input('glob is I')
        parse_input.process_input('prok is V')
        parse_input.process_input('pish is X')
        parse_input.process_input('tegj is L')
        parse_input.process_input('how much is pish tegj glob glob ?').should eql(42)
      end

      it 'get incorrect values' do
        parse_input.process_input('how much is aa bb cc dd ?').should be_nil
      end
    end

    context 'get credit values ' do
      it 'get correct values' do
        parse_input.process_input('glob is I')
        parse_input.process_input('prok is V')
        parse_input.process_input('glob glob Silver is 34 Credits')
        parse_input.process_input('how many Credits is glob prok Silver ?').should eql(68)
      end

      it 'get incorrect values' do
        parse_input.process_input('how many Credits is glob prok Abc ?').should be_nil
      end
    end

  end




end
