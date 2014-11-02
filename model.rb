ActiveRecord::Base.establish_connection('sqlite3:///proconist.db')

class Entrant < ActiveRecord::Base
  def arr_media
    media.split(',')
  end

  def arr_media_urls
    media_urls.split(',')
  end

  def media_list
    arr_media.zip(arr_media_urls)
  end
end
