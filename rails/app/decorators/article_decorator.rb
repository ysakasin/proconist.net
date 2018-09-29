module ArticleDecorator
  def date
    created_at.strftime('%Y年%m月%d日')
  end

  def date_hyphen
    created_at.strftime('%F')
  end

  def categories_link
    article_categories.map do |category|
      "<a href='#{category_path(category.url)}'>#{category.name}</a>"
    end.join(',&nbsp;')
  end
end
