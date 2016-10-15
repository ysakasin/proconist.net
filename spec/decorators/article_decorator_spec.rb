require 'rails_helper'

describe ArticleDecorator do
  let(:article) { Article.new.extend ArticleDecorator }
  subject { article }
  it { should be_a Article }
end
