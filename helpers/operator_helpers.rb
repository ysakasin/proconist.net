module OperatorHelpers
  SNS_SERVICES_DICTIONARY = {
    github:       { name: 'GitHub',     fa_class: 'fa-github-alt' },
    bitbucket:    { name: 'Bitbucket',  fa_class: 'fa-bitbucket' },
    slideshare:   { name: 'SlideShare', fa_class: 'fa-slideshare' },
    twitter:      { name: 'Twitter',    fa_class: 'fa-twitter' },
    facebook:     { name: 'Facebook',   fa_class: 'fa-facebook-square' },
    site:         { name: 'Webサイト',     fa_class: 'fa-globe' }
  }

  def sns_name(sns)
    SNS_SERVICES_DICTIONARY[sns.to_sym][:name]
  end

  def sns_fa_class(sns)
    SNS_SERVICES_DICTIONARY[sns.to_sym][:fa_class]
  end
end
