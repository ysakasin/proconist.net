module DocumentDecorator
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

  def fa_class
    FA_CLASS_DICTIONARY[document_type]
  end
end
