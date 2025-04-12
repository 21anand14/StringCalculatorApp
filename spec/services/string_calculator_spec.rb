require 'rails_helper'

RSpec.describe StringCalculator do
  describe '#add' do
    it 'returns 0 for an empty string' do
      expect(described_class.new.add("")).to eq(0)
    end

    it 'returns number itself for a single number string' do
      expect(described_class.new.add("1")).to eq(1)
    end
  end
end
