require 'rails_helper'

describe DocumentDecorator do
  let(:document) { Document.new.extend DocumentDecorator }
  subject { document }
  it { should be_a Document }

  describe '#fa_class' do
    [
      { 'github':       'fa-github-alt' },
      { 'bitbucket':    'fa-bitbucket' },
      { 'other_repo':   'fa-database' },
      { 'slideshare':   'fa-slideshare' },
      { 'other_slide':  'fa-desktop' },
      { 'twitter':      'fa-twitter' },
      { 'facebook':     'fa-facebook-square' },
      { 'site':         'fa-globe' }
    ].each do |document_type, fa_class_name|
      context "document_type is #{document_type}" do
        let(:document) do
          Fabricate(:document, document_type: document_type).extend(DocumentDecorator)
        end

        it { expect(document.fa_class).to eq fa_class_name }
      end
    end
  end

  describe '#document_type_ja' do
    [
      { 'github':       'GitHub' },
      { 'bitbucket':    'Bitbucket' },
      { 'other_repo':   'リポジトリ' },
      { 'slideshare':   'SlideShare' },
      { 'other_slide':  '解説スライド' },
      { 'twitter':      'Twitter' },
      { 'facebook':     'Facebook' },
      { 'site':         'Webサイト' }
    ].each do |document_type, name_ja|
      context "document_type is #{document_type}" do
        let(:document) do
          Fabricate(:document, document_type: document_type).extend(DocumentDecorator)
        end

        it { expect(document.document_type_ja).to eq name_ja }
      end
    end
  end
end
