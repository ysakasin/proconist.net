module ApplicationHelper
  def page_title
    !@title.blank? ? @title + ' - Proconist.net' : 'Proconist.net'
  end

  def ogp_description
    @ogp_description || '高専プロコン作品のソースコードやプレゼンテーションまとめ。高専生プロコニストのアップスパイラルを生み出します'
  end

  def ogp_url
    @ogp_url || 'https://proconist.net'
  end

  def ogp_img
    @ogp_img || 'https://proconist.net/img/ogp.png'
  end
end
