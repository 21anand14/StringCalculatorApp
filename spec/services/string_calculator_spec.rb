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
  end
end
