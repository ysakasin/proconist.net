module HistoryDecorator
  def label_name
    case type
    when :product
      '作品'
    when :entry
      '記事'
    when :notice
      'お知らせ'
    end
  end

  def label_class
    case type
    when :product
      'label-info'
    when :entry
      'label-warning'
    when :notice
      'label-danger'
    end
  end

  def options_array
    [['作品', 0], ['記事', 1], ['お知らせ', 2]].freeze
  end
end
