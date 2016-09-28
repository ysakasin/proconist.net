module ApplicationHelper
  def page_title
    !@title.blank? ? @title + ' - Proconist.net' : 'Proconist.net'
  end
end
