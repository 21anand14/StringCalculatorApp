require 'rails_helper'

RSpec.describe StringCalculator do
  describe '#add' do
    it 'returns 0 for an empty string' do
      expect(described_class.new.add("")).to eq(0)
    end

    it 'returns number itself for a single number string' do
      expect(described_class.new.add("1")).to eq(1)
    end

    it 'returns the sum of two comma-separated numbers' do
      expect(described_class.new.add("3,4")).to eq(7)
    end
    
    it 'returns the sum of multiple comma-separated numbers' do
      expect(described_class.new.add("1,2,3,4,5")).to eq(15)
    end

    it 'handles newlines between numbers' do
      expect(described_class.new.add("2\n2,3")).to eq(7)
    end

    it 'handles multiple newlines between numbers' do
      expect(described_class.new.add("2\n2\n3")).to eq(7)
    end

    it 'handling different delimiter like ;' do
      expect(described_class.new.add("//;\n1;2;4")).to eq(7)
    end
    
    it 'handling different delimiter like *' do
      expect(described_class.new.add("//*\n3*4")).to eq(7)
    end

    it 'raises an exception for negative numbers' do
      expect { described_class.new.add("1,-2,3") }
        .to raise_error(ArgumentError, "negative numbers not allowed: -2")
    end
    
    it 'raises an exception for multiple negative numbers' do
      expect { described_class.new.add("-1,-2,3") }
        .to raise_error(ArgumentError, "negative numbers not allowed: -1, -2")
    end

    it 'raises an exception for negative numbers with different delimiter' do
      expect { described_class.new.add("//;\n1;-2;4") }
        .to raise_error(ArgumentError, "negative numbers not allowed: -2")
    end

    it 'ignore numbers greater than 1000' do
      expect(described_class.new.add("7,1001")).to eq(7)
    end

    it 'supports delimiters of any length' do
      expect(described_class.new.add("//[***]\n2***2***3")).to eq(7)
    end

    it 'supports multiple delimiters' do
      expect(described_class.new.add("//[*][%]\n2*2%3")).to eq(7)
    end

    it 'supports multiple delimiters of any length' do
      expect(described_class.new.add("//[***][%%]\n2***2%%3")).to eq(7)
    end
  end
end
