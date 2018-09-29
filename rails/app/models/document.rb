class Document < ApplicationRecord
  belongs_to :product

  scope :githubs,       -> { where(document_type: 'github') }
  scope :bitbuckets,    -> { where(document_type: 'bitbucket') }
  scope :other_repos,   -> { where(document_type: 'other_repo') }
  scope :slideshares,   -> { where(document_type: 'slideshare') }
  scope :other_slides,  -> { where(document_type: 'other_slides') }
  scope :twitters,      -> { where(document_type: 'twitter') }
  scope :facebooks,     -> { where(document_type: 'facebook') }
  scope :sites,         -> { where(document_type: 'site') }
end
