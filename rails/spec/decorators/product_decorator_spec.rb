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
end
