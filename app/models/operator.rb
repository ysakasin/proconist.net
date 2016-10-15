# rubocop:disable Style/Next

class Operator < ApplicationRecord
  has_secure_password

  has_many :articles

  SNS_SERVICES_DICTIONARY = {
    'github':       { name: 'GitHub',     fa_class: 'fa-github-alt' },
    'bitbucket':    { name: 'Bitbucket',  fa_class: 'fa-bitbucket' },
    'slideshare':   { name: 'SlideShare', fa_class: 'fa-slideshare' },
    'twitter':      { name: 'Twitter',    fa_class: 'fa-twitter' },
    'facebook':     { name: 'Facebook',   fa_class: 'fa-facebook-square' },
    'site':         { name: 'Webサイト',     fa_class: 'fa-globe' }
  }.freeze

  def sns
    %w(github bitbucket slideshare twitter facebook site).map do |name|
      if send(name)
        {
          service: SNS_SERVICES_DICTIONARY[name.to_sym][:name],
          url: send(name),
          fa_class: SNS_SERVICES_DICTIONARY[name.to_sym][:fa_class]
        }
      end
    end.compact
  end

end
