require 'rails_helper'

RSpec.describe History, type: :model do
  describe '#type' do
    subject do
      history.type
    end

    [
      { label: 0, type: :product },
      { label: 1, type: :entry },
      { label: 2, type: :notice }
    ].each do |set|
      context "label is #{set[:label]}" do
        let(:history) { Fabricate(:history, label: set[:label]) }
        it { should eq set[:type] }
      end
    end
  end
end
