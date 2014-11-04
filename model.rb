ActiveRecord::Base.establish_connection(
  "adapter" => "sqlite3",
  "database" => "./proconist.db")

class Entrant < ActiveRecord::Base
  enum section: {competition: 0, themed: 1, original: 2}
  enum code: {github: 1, bitbucket: 2, other_code: 0}
  enum slide: {slideshare: 1, other_slide: 0}
  enum sns: {twitter: 1, facebook: 2, other_sns: 0}

  ENUMS = ['section', 'code', 'slide', 'sns']

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
