require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "#section_name" do
    context "課題部門" do
      let(:product) { Fabricate(:product, section: 0) }
      it{ expect(product.section_name).to eq 'competition' }
    end

    context "競技部門" do
      let(:product) { Fabricate(:product, section: 1) }
      it{ expect(product.section_name).to eq 'themed' }
    end

    context "自由部門" do
      let(:product) { Fabricate(:product, section: 2) }
      it{ expect(product.section_name).to eq 'original' }
    end
  end

end
