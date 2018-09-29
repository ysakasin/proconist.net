module ProductDecorator
  def panel_class
    if documents.present?
      'panel-primary'
    else
      'panel-default'
    end
  end
end
