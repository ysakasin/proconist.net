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
end
