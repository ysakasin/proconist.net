module ArticleDecorator
  def date
    created_at.strftime('%Y年%m月%d日')
  end

  def date_hyphen
    created_at.strftime('%F')
  end
end
