require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#page_title' do
    context '@title is not blank' do
      before do
        @title = 'hoge'
      end

      it { expect(helper.page_title).to eq 'hoge - Proconist.net' }
    end

    context '@title is blank' do
      it { expect(helper.page_title).to eq 'Proconist.net' }
    end
  end

  describe '#ogp_description' do
    context '@ogp_description is not blank' do
      before do
        @ogp_description = 'another description'
      end

      it { expect(helper.ogp_description).to eq 'another description' }
    end

    context '@ogp_description is blank' do
      it 'should eq default description' do
        expect(helper.ogp_description).to eq '高専プロコン作品のソースコードやプレゼンテーションまとめ。高専生プロコニストのアップスパイラルを生み出します'
      end
    end
  end

  describe '#ogp_url' do
    context '@ogp_url is not blank' do
      before do
        @ogp_url = 'https://proconist.net/dummy'
      end

      it { expect(helper.ogp_url).to eq 'https://proconist.net/dummy' }
    end

    context '@ogp_url is blank' do
      it { expect(helper.ogp_url).to eq 'https://proconist.net' }
    end
  end

  describe '#ogp_img' do
    context '@ogp_img is not blank' do
      before do
        @ogp_img = 'https://proconist.net/dummy.png'
      end

      it { expect(helper.ogp_img).to eq 'https://proconist.net/dummy.png' }
    end

    context '@ogp_img is blank' do
      it { expect(helper.ogp_img).to eq 'https://proconist.net/img/ogp.png' }
    end
  end
end
