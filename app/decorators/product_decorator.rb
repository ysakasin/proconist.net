module ProductDecorator
  def panel_class
    if documents.present?
      'panel-primary'
    else
      'panel-default'
    end
  end

  def section_name_ja
    case section
    when 0
      '競技部門'
    when 1
      '課題部門'
    when 2
      '自由部門'
    end
  end
end
