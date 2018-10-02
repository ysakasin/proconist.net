require "uri"

module ApplicationHelper
  def page_title
    title = yield_content(:title) || current_page.data.title
    if title.present?
      title + ' - Proconist.net'
    else
      'Proconist.net'
    end
  end

  def ogp_description
    current_page.data.ogp_description || '高専プロコン作品のソースコードやプレゼンテーションまとめ。高専生プロコニストのアップスパイラルを生み出します'
  end

  def ogp_url
    current_page.data.ogp_url || URI.join(config[:host], current_page.path)
  end

  def ogp_img_path
    current_page.data.ogp_img_path || 'ogp.png'
  end
end
