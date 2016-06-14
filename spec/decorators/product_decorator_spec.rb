require 'rails_helper'

describe ProductDecorator do
  let(:product) { Product.new.extend ProductDecorator }
  subject { product }
  it { should be_a Product }

  describe '#panel_class' do
    let(:product) { Fabricate(:product).extend(ProductDecorator) }

    context 'has documents' do
      let!(:document) do
        Fabricate(:document, product: product)
      end

      it { expect(product.panel_class).to eq 'panel-primary' }
    end

    context 'no documeents' do
      it { expect(product.panel_class).to eq 'panel-default' }
    end
  end

  describe '#section_name_ja' do
    context 'competition' do
      let(:product) { Fabricate(:product, section: 0).extend(ProductDecorator) }
      it { expect(product.section_name_ja).to eq '競技部門' }
    end

    context 'themed' do
      let(:product) { Fabricate(:product, section: 1).extend(ProductDecorator) }
      it { expect(product.section_name_ja).to eq '課題部門' }
    end

    context 'original' do
      let(:product) { Fabricate(:product, section: 2).extend(ProductDecorator) }
      it { expect(product.section_name_ja).to eq '自由部門' }
    end
  end
end
