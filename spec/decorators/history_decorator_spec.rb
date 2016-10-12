require 'rails_helper'

describe HistoryDecorator do
  let(:history) { History.new.extend HistoryDecorator }
  subject { history }
  it { should be_a History }

  describe '#label_name' do
    subject do
      history.label_name
    end

    [
      { label: 0, name: '作品' },
      { label: 1, name: '記事' },
      { label: 2, name: 'お知らせ' }
    ].each do |set|
      context "label is #{set[:label]}" do
        let(:history) { Fabricate(:history, label: set[:label]).extend HistoryDecorator }
        it { should eq set[:name] }
      end
    end
  end

  describe '#label_class' do
    subject do
      history.label_class
    end

    [
      { label: 0, class: 'label-info' },
      { label: 1, class: 'label-warning' },
      { label: 2, class: 'label-danger' }
    ].each do |set|
      context "label is #{set[:label]}" do
        let(:history) { Fabricate(:history, label: set[:label]).extend HistoryDecorator }
        it { should eq set[:class] }
      end
    end
  end
end
