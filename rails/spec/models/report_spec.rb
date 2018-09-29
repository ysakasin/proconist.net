require 'rails_helper'

RSpec.describe Report, type: :model do
  describe 'validation' do
    subject do
      report.valid?
    end

    context 'email address' do
      context 'invalid address' do
        let(:report) do
          Fabricate.build(:report, email: 'invalid@com')
        end
        it { should be_falsey }
      end
    end

    context 'section' do
      context 'invalid section number' do
        let(:report) do
          Fabricate.build(:report, section: 20)
        end
        it { should be_falsey }
      end
    end

    context 'product_name' do
      context 'empty product_name' do
        let(:report) do
          Fabricate.build(:report, product_name: ' ')
        end
        it { should be_falsey }
      end
    end
  end
end
