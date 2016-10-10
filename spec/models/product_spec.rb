require 'rails_helper'

RSpec.describe Product, type: :model do
  describe '#section_name' do
    context '課題部門' do
      let(:product) { Fabricate(:product, section: 0) }
      it { expect(product.section_name).to eq 'competition' }
    end

    context '競技部門' do
      let(:product) { Fabricate(:product, section: 1) }
      it { expect(product.section_name).to eq 'themed' }
    end

    context '自由部門' do
      let(:product) { Fabricate(:product, section: 2) }
      it { expect(product.section_name).to eq 'original' }
    end
  end

  describe '#section_name_ja' do
    context 'competition' do
      let(:product) { Fabricate(:product, section: 0) }
      it { expect(product.section_name_ja).to eq '競技部門' }
    end

    context 'themed' do
      let(:product) { Fabricate(:product, section: 1) }
      it { expect(product.section_name_ja).to eq '課題部門' }
    end

    context 'original' do
      let(:product) { Fabricate(:product, section: 2) }
      it { expect(product.section_name_ja).to eq '自由部門' }
    end
  end

end
