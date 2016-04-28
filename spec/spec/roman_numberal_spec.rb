require 'spec_helper'
describe Galaxy::RomanNumberal do


  describe "#string format valid" do
    context 'value valid' do
      it 'value valid' do
        Galaxy::RomanNumberal.new('MMVI').value.should eql(2006)
        Galaxy::RomanNumberal.new('MCMIII').value.should eql(1903)
        Galaxy::RomanNumberal.new('MCMXLIV').value.should eql(1944)
      end
    end

    context 'repeat three valid' do
      it 'I,X,C,M can be repeat three time' do
        Galaxy::RomanNumberal.new('III').value.should eql(3)
        Galaxy::RomanNumberal.new('XXX').value.should eql(30)
        Galaxy::RomanNumberal.new('CCC').value.should eql(300)
        Galaxy::RomanNumberal.new('MMMIV').value.should eql(3004)
      end

      it 'I X C M can not repeat more than three times, D L V can not repeat' do
        expect {
          Galaxy::RomanNumberal.new('MIIII')
        }.to raise_error(Galaxy::StringFormatException)
        expect {
          Galaxy::RomanNumberal.new('MMMMMM')
        }.to raise_error(Galaxy::StringFormatException)
        expect {
          Galaxy::RomanNumberal.new('CCCCC')
        }.to raise_error(Galaxy::StringFormatException)
        expect {
          Galaxy::RomanNumberal.new('XXXXXX')
        }.to raise_error(Galaxy::StringFormatException)
        expect {
          Galaxy::RomanNumberal.new('DD')
        }.to raise_error(Galaxy::StringFormatException)
        expect {
          Galaxy::RomanNumberal.new('LL')
        }.to raise_error(Galaxy::StringFormatException)
        expect {
          Galaxy::RomanNumberal.new('VV')
        }.to raise_error(Galaxy::StringFormatException)

      end
    end

    context 'subtracted valid' do
      it 'I can be subtraced from V and X. X can be subtracted from L
        and C.C can be subtracted from D and M.' do
        Galaxy::RomanNumberal.new('IV').value.should eql(4)
        Galaxy::RomanNumberal.new('MIX').value.should eql(1009)
        Galaxy::RomanNumberal.new('DXL').value.should eql(540)
        Galaxy::RomanNumberal.new('MMXCI').value.should eql(2091)
        Galaxy::RomanNumberal.new('DCD').value.should eql(900)
        Galaxy::RomanNumberal.new('MMMCM').value.should eql(3900)
      end

      it 'V L D can never be subtracted' do
        expect {
          Galaxy::RomanNumberal.new('VX')
        }.to raise_error(Galaxy::StringFormatException)
        expect {
          Galaxy::RomanNumberal.new('LM')
        }.to raise_error(Galaxy::StringFormatException)
        expect {
          Galaxy::RomanNumberal.new('DM')
        }.to raise_error(Galaxy::StringFormatException)

      end
    end

  end




end
