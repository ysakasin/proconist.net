module ProductHelpers
  FA_CLASS_DICTIONARY = {
    'github':       'fa-github-alt',
    'bitbucket':    'fa-bitbucket',
    'other_repo':   'fa-database',
    'slideshare':   'fa-slideshare',
    'other_slide':  'fa-desktop',
    'twitter':      'fa-twitter',
    'facebook':     'fa-facebook-square',
    'site':         'fa-globe',
  }.freeze

  DOCUMENT_TYPE_NAME_DICTIONARY = {
    'github':       'GitHub',
    'bitbucket':    'Bitbucket',
    'other_repo':   'リポジトリ',
    'slideshare':   'SlideShare',
    'other_slide':  '解説スライド',
    'twitter':      'Twitter',
    'facebook':     'Facebook',
    'site':         'Webサイト',
  }.freeze

  def document_fa_class(type)
    FA_CLASS_DICTIONARY[type.to_sym]
  end

  def document_name(type)
    DOCUMENT_TYPE_NAME_DICTIONARY[type.to_sym]
  end
end
